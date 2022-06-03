import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:steroids/src/game/components/polygonAsteroid.dart';
import 'package:steroids/src/game/extensions/generic.dart';

///
/// explosives detonating after a ship is destroyed
///
Particle shipExplosion() {
  Vector2 cellSize = Vector2(20, 20);
  final Random rnd = Random();

  /// Returns random [Vector2] within a virtual grid cell
  Vector2 randomCellVector2() {
    return (Vector2.random() - Vector2.random())..multiply(cellSize);
  }
  // A pallete to paint over the "sky"
  final paints = [
    Colors.amber,
    Colors.amberAccent,
    Colors.red,
    Colors.redAccent,
    Colors.yellow,
    Colors.yellowAccent,
    // Adds a nice "lense" tint
    // to overall effect
    Colors.blue,
  ].map((color) => Paint()..color = color).toList();

  return Particle.generate(
    count: 10,
    generator: (i) {
      final initialSpeed = randomCellVector2();
      final gravity = Vector2(0, 0);

      return AcceleratedParticle(
        speed: initialSpeed,
        acceleration: gravity,
        child: ComputedParticle(
          renderer: (canvas, particle) {
            final paint = paints.randomElement();
            canvas.drawCircle(
              Offset.zero,
              1 + (3 * particle.progress),
              paint,
            );
          },
        ),
      );
    },
  );
}

///
/// particles after an asteroid splits
///
Particle asteroidSplitting(PolygonAsteroid asteroid) {
  Vector2 cellSize = Vector2(40, 40);
  final Random rnd = Random();

  /// Returns random [Vector2] within a virtual grid cell
  Vector2 randomCellVector2() {
    return (Vector2.random() - Vector2.random())..multiply(cellSize);
  }

  final paints = [
    Colors.grey,
    Colors.black26,
    Colors.blueGrey,
    Colors.brown,
    Colors.blue,
  ].map((color) => Paint()..color = color).toList();

  return Particle.generate(
    count: 5 + asteroid.radius.toInt(),
    generator: (i) {
      final speed = randomCellVector2() + asteroid.initialSpeed;
      final gravity = Vector2(0, 0);

      return AcceleratedParticle(
        speed: speed,
        lifespan: 2,
        acceleration: gravity,
        child: ComputedParticle(
          renderer: (canvas, particle) {
            final paint = paints.randomElement();
            canvas.drawCircle(
              Offset(asteroid.radius, asteroid.radius),
              1,
              paint,
            );
          },
        ),
      );
    },
  );
}