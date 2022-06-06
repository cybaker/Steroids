import 'dart:math';

import 'package:steroids/src/audio/sounds.dart';

import '../components/alien.dart';
import '../components/pirate.dart';
import '../components/polygonAsteroid.dart';
import '../extensions/component_effects.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/bullet.dart';
import '../station/station.dart';
import '../steroids.dart';
import '../components/powerups.dart';
import 'player_power_guage.dart';
import 'player_storage_guage.dart';
import 'player_thrust.dart';

class Player extends SpriteComponent with KeyboardHandler, HasGameRef<SteroidsLevel>, CollisionCallbacks {
  Player()
      : super(
          size: Vector2(40, 40),
          priority: 5,
        );

  PlayerThrust _thrustComponent = PlayerThrust();
  bool _isThrusting = false;

  Vector2 direction = Vector2.zero();
  Vector2 deltaPosition = Vector2.zero();
  double fireTimeout = 0;
  double scaleFireTimeout = 1;

  static const halfPi = pi / 2;
  static const speed = 2.0;
  static const rotationSpeed = pi / 30;

  static const maxShipPower = 100.0;
  static const maxShipStorage = 100.0;
  static const shipPowerRecovery = 1;
  static const firePowerConsumption = 2;
  static const thrustPowerConsumption = 0.1;

  ValueNotifier<double> shipPower = ValueNotifier<double>(maxShipPower);
  ValueNotifier<double> shipStorage = ValueNotifier<double>(0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('ship_A.png');

    add(PlayerStorageGuage(radius: 15));
    add(PlayerPowerGuage(radius: 20));
    await add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    final newPosition = position + direction * speed * dt;
    deltaPosition = position - newPosition;
    position = newPosition;

    fireTimeout -= dt;
    _handleKeyPresses();
    _powerRegeneration(dt);
  }

  void _powerRegeneration(double dt) {
    shipPower.value += shipPowerRecovery * gameRef.level.playerPowerRegenMultiplier * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // debugPrint('Collided with $other');
    if (other is Station)
      dockWithStation(other);
    else if (other is PolygonAsteroid) _collideWithAsteroid(other);
    else if (other is PowerUp) _collideWithPowerup(other);
    else if (other is Pirate) _collideWithPirate(other);
    else if (other is Alien) _collideWithAlien(other);
    super.onCollision(intersectionPoints, other);
  }

  dockWithStation(Station other) {
    _transferMaterialToStation(other);
    _restoreShields();
  }

  _collideWithAlien(Alien alien) {
    alien.damageShip(this.shipPower.value);
  }

  _collideWithPirate(Pirate pirate) {
    shipStorage.value = 0;
  }

  _collideWithPowerup(PowerUp powerup) {
    gameRef.audio.playSfx(SfxType.powerup);
    gameRef.remove(powerup);
    if (powerup is FasterShot) {
      scaleFireTimeout *= 0.8;
    }
    if (powerup is Shield) {
      shipPower.value = maxShipPower;
    }
  }

  _collideWithAsteroid(PolygonAsteroid asteroid) {
    _applyAsteroidCollision(asteroid);
    asteroid.hitAsteroid();
  }

  _applyAsteroidCollision(PolygonAsteroid asteroid) {
    if (asteroid.isSmallAsteroid) {
      _storeMaterial(asteroid.radius);
    } else {
      damageShip(asteroid.radius);
      shake();
    }
  }

  _restoreShields() {
    shipPower.value = maxShipPower;
  }

  damageShip(double damage) {
    shipPower.value -= damage * gameRef.level.asteroidDamageMultiplier;
  }

  _storeMaterial(double amount) {
    var value = shipStorage.value + amount;
    if (value > maxShipStorage) value = maxShipStorage;
    shipStorage.value = value;
    debugPrint('Ship storage adding $amount');
  }

  _transferMaterialToStation(Station station) {
    // transfer all gathered asteroid material to station, recharge shields
    if (shipStorage.value > 0) {
      // debugPrint('Transferring ${shipStorage.value}');
      station.addStorage(shipStorage.value);
      shipStorage.value = 0;
    }
  }

  _thrustShip(double rotation, double thrust) {
    final newThrust = Vector2(cos(rotation - halfPi) * thrust, sin(rotation - halfPi) * thrust);
    final total = direction + newThrust;
    if (total.x * total.x + total.y * total.y < 100 * 100) {
      // maximum speed
      direction = total;
    }
    _thrustConsumePower();
    _makeThrustSound();
    _showThrust(true);
  }

  _thrustConsumePower() {
    shipPower.value -= gameRef.level.playerThrustMultiplier * thrustPowerConsumption;
  }

  _handleKeyPresses() {
    // debugPrint('onKeyEvent ${gameRef.pressedKeySet}');

    if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowLeft)) {
      angle -= rotationSpeed;
    } else if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowRight)) {
      angle += rotationSpeed;
    }
    if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowUp)) {
      _thrustShip(angle, 1);
    } else if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.arrowDown)) {
      _thrustShip(angle, -0.1);
    } else {
      _showThrust(false);
    }
    if (gameRef.pressedKeySet.contains(LogicalKeyboardKey.space)) {
      if (_canFireBullet) _fireBullet();
    }
  }

  _showThrust(bool thrust) {
    if (thrust) {
      if (!_isThrusting) {
        add(_thrustComponent);
        _isThrusting = true;
      }
    } else {
      if (_isThrusting) {
        remove(_thrustComponent);
        _isThrusting = false;
      }
    }
  }

  bool get _canFireBullet => fireTimeout <= 0;

  _fireBullet() {
    final shipDirection = Vector2(cos(angle - pi / 2), sin(angle - pi / 2));
    final nosePoint = Vector2(15, 0)..rotate(angle - pi / 2);
    gameRef.add(
        Bullet(radius: 2, velocityVector: shipDirection * 200, initialPosition: position + nosePoint, timeToLive: 1));

    fireTimeout = gameRef.level.playerBulletFireLifetimeSecs * scaleFireTimeout;

    _fireConsumePower();

    gameRef.audio.playSfx(SfxType.bullet);
  }

  _fireConsumePower() {
    shipPower.value -= gameRef.level.playerFireMultiplier * 2.0;
  }

  int thrustThrottleCount = 0; // just throttling the thrust playing not every frame
  _makeThrustSound() {
    if (thrustThrottleCount++ % 30 == 0) {
      gameRef.audio.playSfx(SfxType.thrust);
    }
  }
}
