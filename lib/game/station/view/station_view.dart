import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Roids/game/game.dart';
import 'package:intl/intl.dart';

class StationViewPanel extends StatelessWidget {
  const StationViewPanel({required this.stationStorage, Key? key}) : super(key: key);

  final ValueNotifier<double> stationStorage;

  @override
  Widget build(BuildContext context) {
    return PanelContainer(
      child: ValueListenableBuilder(
        valueListenable: stationStorage,
        builder: (context, value, child) {
          final numberFormat = NumberFormat('##0.0', 'en_US');
          return Text('Stores: ${numberFormat.format(value)}');
        },
      ),
    );
  }
}
