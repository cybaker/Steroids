import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../util/sounds.dart';
import '../steroids.dart';

class Asteroid extends CircleComponent with HasGameRef<SteroidsLevel> {
  Asteroid({required double radius, required this.initialPosition, required this.initialSpeed, required this.minimumRadius}) : super(radius: radius);

  final Vector2 initialPosition;
  final Vector2 initialSpeed;
  final double minimumRadius;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    if (size.x < minimumRadius) {
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
  }

  void hitAsteroid() {
    if (size.x > minimumRadius) {
      splitAsteroid();
    }
    Sounds.playAsteroidSound(this);
    gameRef.remove(this);
  }

  void splitAsteroid() {
    var newSize = size.x/4;
    gameRef
      ..add(smallerAsteroid(newSize))
      ..add(smallerAsteroid(newSize))
      ..add(smallerAsteroid(newSize))
      ..add(smallerAsteroid(newSize));
  }

  Asteroid smallerAsteroid(double radius) {
    return Asteroid(
        radius: radius,
        initialPosition: position,
        initialSpeed: Vector2(
          randomVelocity(),
          randomVelocity(),
        ),
        minimumRadius: minimumRadius,
    );
  }

  double randomVelocity() {
    return Random().nextDouble() * 1 - 0.5;
  }

  bool isSmallAsteroid() {
    return size.x < minimumRadius;
  }
}
