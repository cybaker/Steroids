import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../model/Sounds.dart';
import '../model/asteroid_factory.dart';
import '../steroids.dart';

class Asteroid extends CircleComponent with HasGameRef<Steroids> {
  Asteroid({required double radius, required this.initialPosition, required this.initialSpeed}) : super(radius: radius);

  final Vector2 initialPosition;
  final Vector2 initialSpeed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    if (size.x < AsteroidFactory.smallAsteroidMaxSize) {
      paint = BasicPalette.green.paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
    } else {
      paint = BasicPalette.magenta.paint()..style = PaintingStyle.fill;
    }

    position = initialPosition;

    await add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePositionWithinBounds();
  }

  void updatePositionWithinBounds() {
    position = position - initialSpeed;
    // if (position.x.abs() > Roids.fieldSize) position.x = -position.x;
    // if (position.x.abs() > Roids.fieldSize) position.y = -position.y;
  }

  void hitAsteroid() {
    if (size.x > AsteroidFactory.smallAsteroidMaxSize) {
      splitAsteroid();
    }
    Sounds.playAsteroidSound(size);
    gameRef.remove(this);
  }

  void splitAsteroid() {
    gameRef
      ..add(smallerAsteroid(size.x / 4))
      ..add(smallerAsteroid(size.x / 4))
      ..add(smallerAsteroid(size.x / 4))
      ..add(smallerAsteroid(size.x / 4));
  }

  Asteroid smallerAsteroid(double radius) {
    return Asteroid(
        radius: radius,
        initialPosition: position,
        initialSpeed: Vector2(
          randomVelocity(),
          randomVelocity(),
        ),
    );
  }

  double randomVelocity() {
    return Random().nextDouble() * 1 - 0.5;
  }
}
