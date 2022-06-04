import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../../audio/sounds.dart';
import '../player/player.dart';
import '../steroids.dart';
import 'alien_bullet.dart';
import 'explosion.dart';

class Alien extends SpriteComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  Alien({required this.player})
      : super(
          priority: 3,
          size: Vector2(20, 20),
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

  late double shipPower = gameRef.level.alienPower;

  late double playerAngle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('enemy_D.png');

    await add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    playerAngle = enemyAngle;
    angle = -enemyAngle + pi;
    move(dt, playerAngle);
    _calculateBullets(dt, playerAngle);
  }

  void move(double dt, double playerAngle) {
    moveTimeout -= dt;
    if (_canChangeDirection) {
      moveVector = enemyVector * gameRef.level.alienSpeed;
      moveTimeout = gameRef.level.alienPathChangeIntervalSec;
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
    if (shipPower < 0) {
      gameRef.remove(this);
      gameRef.audio.playSfx(SfxType.enemyDestroyed);
      _addExplosion();
      _addDebris();
    }
  }

  _addDebris() {
    var asteroid1 = gameRef.asteroidFactory.makePolygonAsteroid(gameRef.level, gameRef.level.minAsteroidSize-2);
    asteroid1.initialSpeed = randomSpeed;
    asteroid1.position = this.position;
    gameRef.add(asteroid1);

    var asteroid2 = gameRef.asteroidFactory.makePolygonAsteroid(gameRef.level, gameRef.level.minAsteroidSize-1);
    asteroid2.initialSpeed = randomSpeed;
    asteroid2.position = this.position;
    gameRef.add(asteroid2);
  }

  _addExplosion() {
    gameRef.add(
        ParticleSystemComponent(
          particle: TranslatedParticle(
            lifespan: 1.5,
            offset: this.position,
            child: shipExplosion(),
          ),
        )
    );
  }

  Vector2 get randomSpeed => Vector2(this.randomFromTo(-gameRef.level.pirateSpeed, gameRef.level.pirateSpeed),
      this.randomFromTo(-gameRef.level.pirateSpeed, gameRef.level.pirateSpeed)) / 60;

  double get enemyAngle => atan2(player.position.x - this.position.x, player.position.y - this.position.y);

  Vector2 get enemyVector => Vector2(sin(playerAngle), cos(playerAngle));

  bool get _canFireBullet => fireTimeout <= 0;

  bool get _canChangeDirection => moveTimeout <= 0;

  void _fireBullet(double playerAngle) {
    final bulletVector = enemyVector;
    gameRef.add(EnemyBullet(
        radius: 2,
        velocityVector: bulletVector * gameRef.level.alienBulletSpeed,
        initialPosition: position + bulletVector * 2,
        timeToLive: gameRef.level.alienBulletLifetimeSecs));

    fireTimeout = gameRef.level.playerBulletFireLifetimeSecs * scaleFireTimeout;

    gameRef.audio.playSfx(SfxType.bullet);
  }
}
