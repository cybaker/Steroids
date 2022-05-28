import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../player/player_component.dart';
import '../steroids.dart';
import '../util/sounds.dart';
import 'alien_bullet.dart';

class Alien extends SpriteComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  Alien({required this.player})
      : super(
          size: Vector2(20, 20),
          priority: 3,
        );

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

  late double shipPower = gameRef.level.enemyPower;

  late double playerAngle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('enemy_D.png');

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
      moveVector = enemyVector * gameRef.level.enemySpeed;
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
    if (shipPower < 0) gameRef.remove(this);
  }

  double get enemyAngle => atan2(player.position.x - this.position.x, player.position.y - this.position.y);

  Vector2 get enemyVector => Vector2(sin(playerAngle), cos(playerAngle));

  bool get _canFireBullet => fireTimeout <= 0;
  bool get _canChangeDirection => moveTimeout <= 0;

  void _fireBullet(double playerAngle) {
    final bulletVector = enemyVector;
    gameRef.add(EnemyBullet(
        radius: 2,
        velocityVector: bulletVector * gameRef.level.enemyBulletSpeed,
        initialPosition: position + bulletVector * 2,
        timeToLive: gameRef.level.enemyBulletLifetimeSecs));

    fireTimeout = gameRef.level.playerBulletFireLifetimeSecs * scaleFireTimeout;

    Sounds.playBulletSound();
  }
}
