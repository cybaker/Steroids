import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steroids/src/game/station/station_component.dart';
import 'package:steroids/src/game_internals/level_state.dart';

import '../widgets/panel_container.dart';

class StationViewPanel extends StatelessWidget {
  const StationViewPanel({required this.station, required this.levelState,
    Key? key}) : super(key: key);

  final Station station;
  final LevelState levelState;

  @override
  Widget build(BuildContext context) {
    return PanelContainer(
      child: ValueListenableBuilder<double>(
        valueListenable: station.stationStorage,
        builder: (context, value, child) {
          levelState.setProgress(value.toInt());
          final numberFormat = NumberFormat('##0.0', 'en_US');
          return Text('Stores: ${numberFormat.format(value)}');
        },
      ),
    );
  }
}
