import 'dart:math';

import 'package:flame/components.dart';
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

  PositionComponent makeRandomPolygonAsteroid(GameLevel level) {
    var radius = _randomSize(level.maxAsteroidSize);
    var asteroid = makeRadiusRandomPolygonAsteroid(level, radius);
    asteroid.initialSpeed = asteroid.randomSpeed(level.maxAsteroidSpeed);
    asteroid.setRandomPositionBetween(level.playfieldDimension*1, level.playfieldDimension/2);
    return asteroid;
  }

  PolygonAsteroid makeRadiusRandomPolygonAsteroid(GameLevel level, double radius) {
    var radius = _randomSize(level.maxAsteroidSize);

    var vertices = randomPolygonSweepCircle(16, radius - 3, radius + 3);

    var asteroid = PolygonAsteroid(
      level: level,
      radius: radius,
      minimumRadius: level.minAsteroidSize,
      listOfVertices: vertices,
    );
    return asteroid;
  }

  static List<Vector2> randomPolygonSweepCircle(int count, double minValue, double maxValue) {
    return List<Vector2>.generate(count,
            (index) => coordinate(index * 2 * pi / count,
                randomFromTo(minValue, maxValue)));
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