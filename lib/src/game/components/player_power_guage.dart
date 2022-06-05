import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:steroids/src/game/player/player.dart';

class PlayerPowerGuage extends CircleComponent {
  PlayerPowerGuage({
    priority: 5,
    required double radius,
  }) : super(radius: radius);

  late double lastStrength;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = BasicPalette.green.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    position = Vector2(0, 0);
    lastStrength = power;
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
  _updateStrokeWidth();
  }

  _updateStrokeWidth() {
    if (lastStrength != power) {
      paint.strokeWidth = power * .04;
      lastStrength = power;
    }
  }

  double get power => (parent as Player).shipPower.value;
}
