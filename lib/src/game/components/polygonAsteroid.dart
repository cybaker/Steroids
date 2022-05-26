import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';
import 'package:steroids/src/game/widgets/asteroid_factory.dart';

import '../../level_selection/levels.dart';
import '../steroids.dart';
import '../util/sounds.dart';

class PolygonAsteroid extends PolygonComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  final GameLevel level;

  PolygonAsteroid(
      {required this.level,
      required this.listOfVertices,
      required this.initialSpeed,
      required this.radius,
      required this.minimumRadius})
      : super(listOfVertices);

  final List<Vector2> listOfVertices;
  final Vector2 initialSpeed;
  final double radius;
  final double minimumRadius;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    setShapeColor();
    await add(PolygonHitbox(vertices));
  }

  void setShapeColor() {
    if (radius < level.minAsteroidSize) {
      paint
        ..color = Colors.blue
        ..style = PaintingStyle.fill;
    } else {
      paint
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePositionWithinBounds();
  }

  void updatePositionWithinBounds() {
    keepWithinGameBounds(level);
    position = position - initialSpeed;
  }

  void hitAsteroid() {
    if (radius > minimumRadius) {
      splitAsteroid();
      Sounds.playAsteroidSound();
    } else {
      Sounds.playMineralSound();
    }
    gameRef.remove(this);
  }

  void splitAsteroid() {
    var newSize = radius / 2;
    gameRef
      ..add(smallerAsteroid(newSize))
      ..add(smallerAsteroid(newSize))
      ..add(smallerAsteroid(newSize));
  }

  PolygonAsteroid smallerAsteroid(double radius) {
    var vertices = AsteroidFactory.randomPolygonSweep(16, (radius - 2), (radius + 2));
    var asteroid = PolygonAsteroid(
      level: level,
      initialSpeed: Vector2(
        randomVelocity,
        randomVelocity,
      ),
      radius: radius,
      minimumRadius: level.minAsteroidSize,
      listOfVertices: vertices,
    );
    asteroid.position = this.position;
    return asteroid;
  }

  double get randomVelocity => Random().nextDouble() * 1 - 0.5;

  bool get isSmallAsteroid => radius <= minimumRadius;
}
