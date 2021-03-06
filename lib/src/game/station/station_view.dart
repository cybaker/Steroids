import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steroids/src/game/station/station.dart';
import 'package:steroids/src/game_internals/level_state.dart';
import 'package:steroids/src/level_selection/levels.dart';

import '../../style/palette.dart';

///
/// The space station view panel displays status information of the space station
/// and updates the level state
///
class StationViewPanel extends StatelessWidget {
  const StationViewPanel({required this.station, required this.levelState, required this.level, Key? key})
      : super(key: key);

  final Station station;
  final LevelState levelState;
  final GameLevel level;

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return ValueListenableBuilder<double>(
      valueListenable: station.stationStorage,
      builder: (context, value, child) {
        levelState.setProgress(value.toInt());
        levelState.evaluate();
        return Text(
            'Storage ${100 * value ~/ level.winStorageTarget}%',
            style: palette.subtitleSmall,
            textAlign: TextAlign.center,
          );
      },
    );
  }
}
