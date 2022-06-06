import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../steroids.dart';

class PlayerThrust extends PolygonComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  PlayerThrust({
    priority = 1,
  }) : super(
          [
            Vector2(0.0, 0.0),
            Vector2(1.0, 1.0),
            Vector2(0.0, 4.0),
            Vector2(-1.0, 1.0),
          ],
          scale: Vector2(2, 2),
          position: Vector2(18, 25),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
  }
}
