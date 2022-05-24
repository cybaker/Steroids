import 'package:flutter/material.dart';
import 'package:steroids/src/game/player/player_component.dart';

class PlayerViewPanel extends StatelessWidget {
  const PlayerViewPanel({required this.player, Key? key}) : super(key: key);

  final Player player;

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
        Column(
          children: [
            ValueListenableBuilder<double>(
              valueListenable: player.shipPower,
              builder: (context, value, child) {
                return Column(children: [
                  Text('Shields:'),
                  Slider(
                    value: value,
                    onChanged: (_) {},
                    min: 0,
                    max: 100,
                    thumbColor: Colors.lightGreen,
                    activeColor: Colors.lightGreen,
                  ),
                ]);
              },
            ),
            ValueListenableBuilder<double>(
              valueListenable: player.shipStorage,
              builder: (context, value, child) {
                if (value < 0) value = 0;
                return Column(children: [
                  Text('Cargo:'),
                  Slider(
                    value: value,
                    onChanged: (_) {},
                    min: 0,
                    max: 100,
                    thumbColor: Colors.lightBlue,
                    activeColor: Colors.lightBlue,
                  ),
                ]);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
