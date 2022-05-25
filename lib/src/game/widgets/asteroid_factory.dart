import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:steroids/src/game/components/polygonAsteroid.dart';

import '../../level_selection/levels.dart';

class AsteroidFactory {

  List<Component> makeAsteroids(GameLevel level) {
    return List<Component>.generate(
        level.asteroidCount,
            (i) => makeRandomPolygonAsteroid(level)
    );
  }

  Component makeRandomPolygonAsteroid(GameLevel level) {
    var radius = _randomSize(level.maxAsteroidSize);

    var paint = Paint();
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

    var vertices = randomPolygonSweep(level.asteroidCount, level.minAsteroidSize, level.maxAsteroidSize);

    return PolygonAsteroid(
      level: level,
      initialPosition: initialPosition(level),
      initialSpeed: initialSpeed(level),
      radius: radius,
      minimumRadius: level.minAsteroidSize,
      listOfVertices: vertices,
    );
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