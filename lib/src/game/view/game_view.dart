import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../level_selection/levels.dart';
import '../player/player_view.dart';
import '../steroids.dart';
import '../station/station_view.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key, required this.level}) : super(key: key);

  final GameLevel level;

  @override
  State<GameView> createState() =>
      GameViewState();
}

class GameViewState
    extends State<GameView> {
  late FocusNode gameFocusNode;

  @override
  void initState() {
    super.initState();

    gameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    gameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: MouseRegion(
              onHover: (_) {
                if (!gameFocusNode.hasFocus) {
                  gameFocusNode.requestFocus();
                }
              },
              child: GameWidget(
                focusNode: gameFocusNode,
                game: SteroidsLevel(level: widget.level),
              ),
            ),
          ),
          SizedBox(
            width: 250,
            height: double.infinity,
            child: Column(
              children: [
                PlayerViewPanel(shipStrength: SteroidsLevel.singlePlayer.shipStrength, shipStorage: SteroidsLevel.singlePlayer.shipStorage),
                Expanded(child: StationViewPanel(
                  stationStorage: SteroidsLevel.singleStation.stationStorage,)),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
