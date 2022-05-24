import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/panel_container.dart';

class PlayerViewPanel extends StatelessWidget {
  const PlayerViewPanel({required this.shipStrength, required this.shipStorage, Key? key}) : super(key: key);

  final ValueNotifier<double> shipStrength;
  final ValueNotifier<double> shipStorage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/images/ship_A.png',
            ),
          ),
        ),
        PanelContainer(
          height: 120,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 88,
                child: ValueListenableBuilder(
                  valueListenable: shipStrength,
                  builder: (context, value, child) {
                    final numberFormat = NumberFormat('##0.0', 'en_US');
                    return Text('Shield: ${numberFormat.format(value)}');
                  },
                ),
              ),
              Positioned(
                top: 42,
                left: 40,
                child: ValueListenableBuilder(
                  valueListenable: shipStorage,
                  builder: (context, value, child) {
                    final numberFormat = NumberFormat('##0.0', 'en_US');
                    return Text('Cargo: ${numberFormat.format(value)}');
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
