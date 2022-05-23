import 'dart:math';

import 'package:flame/components.dart';

import '../../level_selection/levels.dart';
import '../components/asteroid.dart';

class AsteroidFactory {

  List<Component> makeAsteroids(GameLevel level) {
    return List<Component>.generate(
        level.asteroidCount,
            (i) => makeRandomAsteroid(level)
    );
  }

  Component makeRandomAsteroid(GameLevel level) {
    return Asteroid(
        radius: _randomSize(level.maxAsteroidSize),
        initialPosition: Vector2(
            _randomFromHalfToDimension(level.playfieldDimension),
            _randomFromHalfToDimension(level.playfieldDimension)),
        initialSpeed: Vector2(_randomStartSpeed(level.maxAsteroidSpeed), _randomStartSpeed(level.maxAsteroidSpeed)),
      minimumRadius: level.minAsteroidSize,
    );
  }


  double _randomSize(double maxSize) {
    return maxSize/4 + Random().nextDouble() * (maxSize*3/4);
  }

  double _randomFromHalfToDimension(int maxDimension) {
    var location = (Random().nextDouble() + 1) * maxDimension / 2;
    return Random().nextBool() ? location : -location;
  }

  double _randomStartSpeed(double maxSpeed) {
    var speed = Random().nextDouble() * maxSpeed;
    return Random().nextBool() ? speed : -speed;
  }
}