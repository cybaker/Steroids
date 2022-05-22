import 'dart:math';

import 'package:flame/components.dart';

import '../components/asteroid.dart';

class AsteroidFactory {

  static const double minAsteroidSize = 5;
  static const double asteroidMaxSize = 20;
  static const double smallAsteroidMaxSize = 6;

  List<Component> makeAsteroids(int level) {
    return List<Component>.generate(
      20,
          (i) =>
          Asteroid(
              radius: 4 + Random().nextDouble() * 10,
              initialPosition: Vector2(Random().nextDouble() * 200 - 100,
                  Random().nextDouble() * 200 - 100),
              initialSpeed: Vector2(Random().nextDouble() * 1 - 0.5,
                  Random().nextDouble() * 1 - 0.5)),
    );
  }
}