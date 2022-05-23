import 'dart:math';

import '../extensions/component_effects.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/bullet.dart';
import '../station/station_component.dart';
import '../steroids.dart';
import '../components/asteroid.dart';
import '../components/powerup.dart';
import '../model/sounds.dart';

class Player extends SpriteComponent with KeyboardHandler, HasGameRef<SteroidsLevel>, CollisionCallbacks {
  Player()
      : super(
          size: Vector2(30, 60),
          priority: 3,
        );

  Vector2 direction = Vector2.zero();
  Vector2 deltaPosition = Vector2.zero();
  double bulletTimeout = 0;

  static const halfPi = pi / 2;
  static const speed = 2.0;
  static const rotationSpeed = pi / 30;

  static const maxShipStrength = 100.0;
  static const maxShipStorage = 100.0;
  static const shipStrengthRecovery = 1 / 60;

  ValueNotifier<double> shipStrength = ValueNotifier<double>(maxShipStrength);
  ValueNotifier<double> shipStorage = ValueNotifier<double>(0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('ship_A.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    final newPosition = position + direction * speed * dt;
    deltaPosition = position - newPosition;
    position = newPosition;

    bulletTimeout -= dt;
    _handleKeyPresses();
    shipStrength.value += shipStrengthRecovery * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // debugPrint('Collided with $other');
    if (other is Station) {
      transferMaterialToStation(other);
    }
    if (other is Asteroid) {
      collideWithAsteroid(other);
    }
    if (other is PowerUp) {
      collideWithPowerup(other);
    }
    super.onCollision(intersectionPoints, other);
  }

  void collideWithPowerup(PowerUp powerup) {
    //TODO add powerup
    gameRef.remove(powerup);
  }

  void collideWithAsteroid(Asteroid asteroid) {
    applyAsteroidHit(asteroid);
    asteroid.hitAsteroid();
  }

  void applyAsteroidHit(Asteroid asteroid) {
    if (asteroid.isSmallAsteroid()) {
      storeMaterial(asteroid.size.x / 2);
    } else {
      damageShip(asteroid.size.x / 2);
      shake();
    }
  }

  void damageShip(double damage) {
    var strength = shipStrength.value;
    strength -= damage;
    if (strength < 0) {
      // end turn?
    }
    shipStrength.value = strength;
  }

  void storeMaterial(double amount) {
    var value = shipStorage.value + amount;
    if (value > maxShipStorage) value = maxShipStorage;
    shipStorage.value = value;
  }

  void transferMaterialToStation(Station station) {
    // transfer all gathered asteroid material to station, recharge shields
    if (shipStorage.value > 0) {
      // debugPrint('Transferring ${shipStorage.value}');
      station.addStorage(shipStorage.value);
      shipStorage.value = 0;
    }
  }

  void _thrustShip(double rotation, double thrust) {
    final newThrust = Vector2(cos(rotation - halfPi) * thrust, sin(rotation - halfPi) * thrust);
    final total = direction + newThrust;
    if (total.x * total.x + total.y * total.y < 100 * 100) {
      // maximum speed
      direction = total;
    }
  }

  void _handleKeyPresses() {
    // debugPrint('onKeyEvent ${gameRef.pressedKeySet}');

    if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowLeft)) {
      angle -= rotationSpeed;
    } else if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowRight)) {
      angle += rotationSpeed;
    }
    if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowUp)) {
      _thrustShip(angle, 1);
      _makeThrustSound();
    } else if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowDown)) {
      _thrustShip(angle, -0.1);
      _makeThrustSound();
    }
    if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.space)) {
      if (_canFireBullet()) _fireBullet();
    }
  }

  bool _canFireBullet() {
    return bulletTimeout <= 0;
  }

  void _fireBullet() {
    final shipDirection = Vector2(cos(angle - pi / 2), sin(angle - pi / 2));
    final nose = Vector2(15, 0)..rotate(angle - pi / 2);
    final bullet = Bullet(
        radius: 2,
        direction: shipDirection,
        initialSpeed: deltaPosition,
        initialPosition: position + nose,
        timeToLive: 1);
    gameRef.add(bullet);
    bulletTimeout = 0.5;

    Sounds.playBulletSound();
  }

  int thrustCount = 0; // just throttling the thrust playing not every frame
  void _makeThrustSound() {
    if (thrustCount++ % 10 == 0) {
      Sounds.playPlayerThrustSound();
    }
  }
}
