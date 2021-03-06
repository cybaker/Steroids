import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../audio/audio_controller.dart';
import '../../game_internals/level_state.dart';
import '../../games_services/games_services.dart';
import '../../games_services/score.dart';
import '../../level_selection/levels.dart';
import '../../player_progress/player_progress.dart';
import '../steroids.dart';
import '../station/station_view.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key, required this.level}) : super(key: key);

  final GameLevel level;

  @override
  State<GameView> createState() => GameViewState();
}

class GameViewState extends State<GameView> {
  late FocusNode gameFocusNode;

  static final _log = Logger('PlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 0);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  late DateTime _startOfPlay;

  late LevelState _levelState;

  late SteroidsLevel _steroidsLevel;

  late GameWidget _gameWidget;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _steroidsLevel = SteroidsLevel(level: widget.level, audio: context.read<AudioController>());

    _levelState = LevelState(
      goal: widget.level.winStorageTarget,
      onWin: _playerWonLevel,
      onLose: _playerLostLevel,
    );

    _startOfPlay = DateTime.now();

    gameFocusNode = FocusNode();

    _gameWidget = GameWidget<SteroidsLevel>(
      focusNode: gameFocusNode,
      game: _steroidsLevel,
    );
  }

  @override
  void dispose() {
    gameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => _levelState,
          ),
        ],
        child: Scaffold(
          body: Stack(
            children: [
              MouseRegion(
                  onHover: (_) {
                    if (!gameFocusNode.hasFocus) {
                      gameFocusNode.requestFocus();
                    }
                  },
                  child: _gameWidget,
                ),
              Padding(
                padding: EdgeInsets.all(16),
                child: StationViewPanel(
                  station: _steroidsLevel.singleStation,
                  levelState: _levelState,
                  level: widget.level,
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _playerWonLevel() async {
    _log.info('Level ${widget.level.number} won');
    debugPrint('GameView.playerWonLevel ${widget.level.number}');

    final score = Score(
      widget.level.number,
      widget.level.difficulty,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.level.number);
    var oldProgress = await playerProgress.getTotalScore();
    playerProgress.setTotalScoreReached(score.score.toDouble() + oldProgress);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    // final audioController = context.read<AudioController>();
    // audioController.playSfx(SfxType.congrats);

    final gamesServicesController = context.read<GamesServicesController?>();
    if (gamesServicesController != null) {
      // Award achievement.
      if (widget.level.awardsAchievement) {
        await gamesServicesController.awardAchievement(
          android: widget.level.achievementIdAndroid!,
          iOS: widget.level.achievementIdIOS!,
        );
      }

      // Send score to leaderboard.
      await gamesServicesController.submitLeaderboardScore(score);
    }

    /// Give the player some time to see the celebration animation.
    await Future<void>.delayed(_celebrationDuration);
    if (!mounted) return;

    GoRouter.of(context).pop();
    GoRouter.of(context).go('/play/won', extra: {'score': score});
  }

  Future<void> _playerLostLevel() async {
    _log.info('Level ${widget.level.number} lost');
    debugPrint('GameView.playerLostLevel ${widget.level.number}');

    final score = Score(
      widget.level.number,
      0,
      DateTime.now().difference(_startOfPlay),
    );
    GoRouter.of(context).pop();
    GoRouter.of(context).go('/play/lost', extra: {'score': score});
  }
}
