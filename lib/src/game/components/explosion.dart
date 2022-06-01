import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

/// Not very realistic firework, yet it highlights
/// use of [ComputedParticle] within other particles,
/// mixing predefined and fully custom behavior.
Particle explosion() {
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

  /// Returns a random element from a given list
  T randomElement<T>(List<T> list) {
    return list[rnd.nextInt(list.length)];
  }

  return Particle.generate(
    count: 10,
    generator: (i) {
      final initialSpeed = randomCellVector2();
      final deceleration = initialSpeed; // * -1;
      final gravity = Vector2(0, 0);

      return AcceleratedParticle(
        speed: initialSpeed,
        acceleration: deceleration + gravity,
        child: ComputedParticle(
          renderer: (canvas, particle) {
            final paint = randomElement(paints);
            // Override the color to dynamically update opacity
            paint.color = paint.color.withOpacity(1 - particle.progress);

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

/// Not very realistic firework, yet it highlights
/// use of [ComputedParticle] within other particles,
/// mixing predefined and fully custom behavior.
Particle smashing(Vector2 initialSpeed) {
  Vector2 cellSize = Vector2(20, 20);
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

  /// Returns a random element from a given list
  T randomElement<T>(List<T> list) {
    return list[rnd.nextInt(list.length)];
  }

  return Particle.generate(
    count: 10,
    generator: (i) {
      final speed = randomCellVector2() + initialSpeed;
      final deceleration = speed; // * -1;
      final gravity = Vector2(0, 0);

      return AcceleratedParticle(
        speed: speed,
        acceleration: deceleration + gravity,
        child: ComputedParticle(
          renderer: (canvas, particle) {
            final paint = randomElement(paints);
            // Override the color to dynamically update opacity
            paint.color = paint.color.withOpacity(1 - particle.progress);

            canvas.drawCircle(
              Offset.zero,
              1,
              paint,
            );
          },
        ),
      );
    },
  );
}