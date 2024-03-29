import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:steroids/src/audio/sounds.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';
import 'package:steroids/src/game/util/asteroid_factory.dart';

import '../steroids.dart';
import 'explosion.dart';

class PolygonAsteroid extends PolygonComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  PolygonAsteroid({priority = 1, required this.listOfVertices, required this.radius, required this.minimumRadius})
      : super(listOfVertices);

  final List<Vector2> listOfVertices;
  late Vector2 initialSpeed;
  final double radius;
  final double minimumRadius;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    setShapeColor();
    await add(PolygonHitbox(vertices)..isSolid=true);
  }

  void setShapeColor() {
    if (radius < gameRef.level.minAsteroidSize) {
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
    updatePositionWithinBounds(dt);
  }

  void updatePositionWithinBounds(double dt) {
    position = position - initialSpeed * dt;
  }

  void hitAsteroid() {
    if (radius > minimumRadius) {
      splitAsteroid();
      gameRef.audio.playSfx(SfxType.asteroid);
      gameRef.add(ParticleSystemComponent(
        particle: TranslatedParticle(
          lifespan: 1,
          offset: this.position,
          child: asteroidParticles(this),
        ),
      ));
    } else {
      gameRef.audio.playSfx(SfxType.resourceScooped);
    }
    gameRef.remove(this);
  }

  void splitAsteroid() {
    var newSize = radius / 2;
    gameRef
      ..add(newAsteroid(newSize))
      ..add(newAsteroid(newSize))
      ..add(newAsteroid(newSize));
  }

  PolygonAsteroid newAsteroid(double radius) {
    var vertices = AsteroidFactory.randomPolygonSweepCircle(16, (radius - 2), (radius + 2));
    var asteroid = PolygonAsteroid(
      radius: radius,
      minimumRadius: gameRef.level.minAsteroidSize,
      listOfVertices: vertices,
    );
    asteroid.initialSpeed = asteroid.randomPlusMinusWithin(gameRef.level.maxAsteroidSpeed);
    asteroid.position = this.position;
    return asteroid;
  }

  bool get isSmallAsteroid => radius <= minimumRadius;
}
