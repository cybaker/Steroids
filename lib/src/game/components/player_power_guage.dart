import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../steroids.dart';

class PlayerPowerGuage extends CircleComponent with HasGameRef<SteroidsLevel> {
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

    position = Vector2((gameRef.singlePlayer.size.x - size.x) / 2, (gameRef.singlePlayer.size.y - size.y) / 2);
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

  double get power => gameRef.singlePlayer.shipPower.value;
}
