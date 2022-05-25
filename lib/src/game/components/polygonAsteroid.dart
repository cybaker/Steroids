import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:steroids/src/game/widgets/asteroid_factory.dart';

import '../../level_selection/levels.dart';
import '../steroids.dart';
import '../util/sounds.dart';

class PolygonAsteroid extends PolygonComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  final GameLevel level;

  PolygonAsteroid(
      {required this.level,
      required this.listOfVertices,
      required this.initialPosition,
      required this.initialSpeed,
      required this.radius,
      required this.minimumRadius})
      : super(listOfVertices);

  final List<Vector2> listOfVertices;
  final Vector2 initialPosition;
  final Vector2 initialSpeed;
  final double radius;
  final double minimumRadius;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    if (radius < level.minAsteroidSize) {
      paint
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
    } else {
      paint
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
    }
    position = initialPosition;
    await add(PolygonHitbox(vertices));
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePositionWithinBounds();
  }

  void updatePositionWithinBounds() {
    position = position - initialSpeed;
  }

  void hitAsteroid() {
    if (size.x > minimumRadius) {
      splitAsteroid();
    }
    Sounds.playAsteroidSound(this);
    gameRef.remove(this);
  }

  void splitAsteroid() {
    var newSize = size.x / 4;
    gameRef
      ..add(smallerAsteroid(newSize))
      ..add(smallerAsteroid(newSize))
      ..add(smallerAsteroid(newSize));
  }

  PolygonAsteroid smallerAsteroid(double radius) {
    var vertices = AsteroidFactory.randomPolygonSweep(10, (radius - 2), (radius + 2));
    return PolygonAsteroid(
      level: level,
      initialPosition: position,
      initialSpeed: Vector2(
        randomVelocity,
        randomVelocity,
      ),
      radius: radius,
      minimumRadius: level.minAsteroidSize,
      listOfVertices: vertices,
    );
  }

  double get randomVelocity => Random().nextDouble() * 1 - 0.5;

  bool get isSmallAsteroid => size.x < minimumRadius;
}
