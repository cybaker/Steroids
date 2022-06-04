import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../../audio/sounds.dart';
import '../player/player.dart';
import '../steroids.dart';
import 'explosion.dart';

class Enemy extends SpriteComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  Enemy({required this.player})
      : super(
          priority: 3,
          size: Vector2(20, 20),
        );

  final Player player;

  double moveTimeoutSetting = 0;
  double moveTimeout = 0;
  Vector2 moveVector = Vector2(0, 0);

  double speed = 2.0;

  late double shipPower;

  late double playerAngle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('enemy_D.png');

    await add(CircleHitbox());

    setupEnemyVariables();
  }

  void setupEnemyVariables() {
    shipPower = gameRef.level.alienPower;
    speed = gameRef.level.alienSpeed;
    moveTimeoutSetting = gameRef.level.alienPathChangeIntervalSec;
  }

  @override
  void update(double dt) {
    super.update(dt);
    playerAngle = enemyAngle;
    angle = -enemyAngle + pi;
    move(dt);
  }

  void move(double dt) {
    moveTimeout -= dt;
    if (_canChangeDirection) {
      moveVector = enemyVector * speed;
      moveTimeout = moveTimeout;
    }
    position = position + moveVector * dt;
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

  double get enemyAngle => atan2(player.position.x - this.position.x, player.position.y - this.position.y);

  Vector2 get enemyVector => Vector2(sin(playerAngle), cos(playerAngle));

  bool get _canChangeDirection => moveTimeout <= 0;

  Vector2 get randomSpeed => Vector2(this.randomFromTo(-speed, speed),
      this.randomFromTo(-speed, speed)) / 60;
}
