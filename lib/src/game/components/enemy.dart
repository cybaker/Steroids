import 'dart:math';

import 'package:steroids/src/level_selection/levels.dart';

import '../extensions/component_effects.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../components/bullet.dart';
import '../player/player_component.dart';
import '../steroids.dart';
import '../util/sounds.dart';

class Enemy extends SpriteComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  Enemy({required this.level, required this.player})
      : super(
          size: Vector2(20, 20),
          priority: 3,
        );

  final GameLevel level;
  final Player player;

  double fireTimeout = 0;
  double scaleFireTimeout = 1;
  double moveTimeout = 0;
  Vector2 moveVector = Vector2(0, 0);

  static const halfPi = pi / 2;
  static const speed = 2.0;
  static const rotationSpeed = pi / 30;

  static const firePowerConsumption = 2;
  static const thrustPowerConsumption = 0.1;

  late double shipPower = level.enemyPower;

  late double playerAngle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('enemy_D.png');
    this.setRandomPositionBetween(0, 2*level.playfieldDimension/4);

    await add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    playerAngle = enemyAngle;
    move(dt, playerAngle);
    _calculateBullets(dt, playerAngle);
  }

  void move(double dt, double playerAngle) {
    moveTimeout -= dt;
    if (_canChangeDirection) {
      moveVector = enemyVector * level.enemySpeed;
    }
    position = position + moveVector * dt;
  }

  void _calculateBullets(double dt, double playerAngle) {
    fireTimeout -= dt;
    if (_canFireBullet) _fireBullet(playerAngle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      gameRef.remove(this);
    }
    super.onCollision(intersectionPoints, other);
  }

  void damageShip(double damage) {
    shipPower -= damage;
  }

  double get enemyAngle => atan2(player.position.x - this.position.x, player.position.y - this.position.y);

  Vector2 get enemyVector => Vector2(cos(playerAngle), sin(playerAngle));

  bool get _canFireBullet => fireTimeout <= 0;
  bool get _canChangeDirection => moveTimeout <= 0;

  void _fireBullet(double playerAngle) {
    final bulletDirection = enemyVector;
    gameRef.add(Bullet(
        radius: 2,
        velocityVector: bulletDirection * level.enemyBulletSpeed,
        initialPosition: position,
        timeToLive: level.enemyBulletLifetimeSecs));

    fireTimeout = level.bulletFireLifetimeSecs * scaleFireTimeout;

    Sounds.playBulletSound();
  }

  int thrustThrottleCount = 0; // just throttling the thrust playing not every frame
  void _makeEnemyThrustSound() {
    if (thrustThrottleCount++ % 2 == 0) {
      Sounds.playPlayerThrustSound();
    }
  }
}
