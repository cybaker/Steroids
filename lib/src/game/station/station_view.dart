import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steroids/src/game_internals/level_state.dart';

import '../widgets/panel_container.dart';

class StationViewPanel extends StatelessWidget {
  const StationViewPanel({required this.stationStorage, required this.levelState,
    Key? key}) : super(key: key);

  final ValueNotifier<double> stationStorage;
  final LevelState levelState;

  @override
  Widget build(BuildContext context) {
    return PanelContainer(
      child: ValueListenableBuilder<double>(
        valueListenable: stationStorage,
        builder: (context, value, child) {
          levelState.setProgress(value.toInt());
          final numberFormat = NumberFormat('##0.0', 'en_US');
          return Text('Stores: ${numberFormat.format(value)}');
        },
      ),
    );
  }
}
