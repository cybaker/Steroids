import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:steroids/src/game/components/polygonAsteroid.dart';

import '../station/station_component.dart';
import '../steroids.dart';

class Bullet extends CircleComponent
    with HasGameRef<SteroidsLevel>,
        CollisionCallbacks {
  Bullet({
    required double radius,
    required this.direction,
    required this.initialPosition,
    required this.timeToLive,
    required this.initialSpeed
  }) : super(radius: radius);

  static const bulletSpeed = 200.0;
  final Vector2 initialSpeed;
  final Vector2 direction;
  final Vector2 initialPosition;
  late double timeToLive;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = BasicPalette.red.paint()
      ..style = PaintingStyle.fill;
    position = initialPosition;
    await add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Station) {
      debugPrint('hit chest');
    }
    if (other is PolygonAsteroid) {
      other.hitAsteroid();
      gameRef.remove(this);
    }
    super.onCollision(points, other);
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);

    position = position - initialSpeed + direction * bulletSpeed * deltaTime;

    updateTimeToLive(deltaTime);
  }

  void updateTimeToLive(double deltaTime) {
    timeToLive -= deltaTime;
    if (timeToLive < 0.0) {
      gameRef.remove(this);
    }
  }
}