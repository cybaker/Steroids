import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steroids/src/game/player/player_component.dart';
import 'package:steroids/src/game_internals/level_state.dart';

import '../../style/palette.dart';

class PlayerViewPanel extends StatelessWidget {
  const PlayerViewPanel({required this.player, required this.levelState, Key? key}) : super(key: key);

  final LevelState levelState;
  final Player player;

  static const _gap = SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

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
                levelState.setShipPower(value);
                levelState.evaluate();
                return Column(children: [
                  Text(
                    'Ship Power',
                    style: palette.subtitleSmall,
                  ),
                  SliderTheme(
                    child: Slider(
                      value: value,
                      onChanged: (_) {},
                      min: 0,
                      max: 100,
                      divisions: 10,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.blue,
                    ),
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 20,
                        thumbShape: SliderComponentShape.noThumb,
                        trackShape: RectangularSliderTrackShape(),
                        activeTickMarkColor: Colors.white),
                  ),
                ]);
              },
            ),
            _gap,
            ValueListenableBuilder<double>(
              valueListenable: player.shipStorage,
              builder: (context, value, child) {
                if (value < 0) value = 0;
                return Column(children: [
                  Text(
                    'Ship Cargo',
                    style: palette.subtitleSmall,
                  ),
                  SliderTheme(
                    child: Slider(
                      value: value,
                      onChanged: (_) {},
                      min: 0,
                      max: 100,
                      divisions: 10,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.brown,
                    ),
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 20,
                        thumbShape: SliderComponentShape.noThumb,
                        trackShape: RectangularSliderTrackShape(),
                        activeTickMarkColor: Colors.white),
                  ),
                ]);
              },
            ),
          ],
        ),
        _gap,
      ],
    );
  }
}
