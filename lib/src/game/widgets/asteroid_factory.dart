import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:steroids/src/game/components/polygonAsteroid.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../../level_selection/levels.dart';

class AsteroidFactory {

  List<Component> makeAsteroids(GameLevel level) {
    return List<Component>.generate(
        level.asteroidCount,
            (i) => makeRandomPolygonAsteroid(level)
    );
  }

  Component makeRandomPolygonAsteroid(GameLevel level) {
    debugPrint('Making Polygon asteroid');
    var radius = _randomSize(level.maxAsteroidSize);

    var vertices = randomPolygonSweep(level.asteroidCount, radius - 3, radius + 3);

    var asteroid = PolygonAsteroid(
      level: level,
      initialSpeed: initialSpeed(level),
      radius: radius,
      minimumRadius: level.minAsteroidSize,
      listOfVertices: vertices,
    );
    asteroid.setRandomPositionBetween(level.playfieldDimension*1, level.playfieldDimension/2);
    debugPrint('Asteroid position = ${asteroid.position}');
    return asteroid;
  }

  static Vector2 initialSpeed(GameLevel level) {
    return Vector2(randomUpTo(level.maxAsteroidSpeed), randomUpTo(level.maxAsteroidSpeed));
  }

  static List<Vector2> randomPolygonSweep(int count, double minRadius, double maxRadius) {
    return List<Vector2>.generate(count,
            (index) => coordinate(index * 2 * pi / count,
                randomFromTo(minRadius, maxRadius)));
  }

  static Vector2 coordinate(double radians, double radius) {
    return Vector2(radius * sin(radians), radius * cos(radians));
  }

  static Vector2 initialPosition(GameLevel level) {
    double dimension = level.playfieldDimension.toDouble();
    return Vector2(
        randomFromTo(-dimension, dimension),
        randomFromTo(-dimension, dimension));
  }

  double _randomSize(double maxSize) {
    return maxSize/4 + Random().nextDouble() * (maxSize*3/4);
  }

  static double randomFromTo(double minDimension, double maxDimension) {
    return (Random().nextDouble() * (maxDimension - minDimension) + minDimension);
  }

  static double randomUpTo(double maxSpeed) {
    var speed = Random().nextDouble() * maxSpeed;
    return Random().nextBool() ? speed : -speed;
  }
}