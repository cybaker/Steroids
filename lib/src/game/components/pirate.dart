import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:steroids/src/audio/sounds.dart';
import 'package:steroids/src/game/components/explosion.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../player/player.dart';
import '../steroids.dart';

class Pirate extends SpriteComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  Pirate({required this.player})
      : super(
          size: Vector2(20, 15),
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

  late double shipPower = gameRef.level.piratePower;

  bool _escaping = false;

  late double pirateAngle;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('skull.png');

    await add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    pirateAngle = enemyAngle;
    angle = -enemyAngle + pi;
    move(dt, pirateAngle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      _escapeFromScreen();
    }
    super.onCollision(intersectionPoints, other);
  }

  void move(double dt, double playerAngle) {
    moveTimeout -= dt;
    _changeDirectionIfTime();
    position = position + moveVector * dt;
    _removeWhenEscaped();
  }

  void _changeDirectionIfTime() {
    if (_canChangeDirection) {
      moveVector = enemyVector * gameRef.level.pirateSpeed;
      moveTimeout = gameRef.level.piratePathChangeIntervalSec;
    }
  }

  void _removeWhenEscaped() {
    if (_escaping) {
      if (position.x.abs() > gameRef.level.playfieldDimension ||
          position.y.abs() > gameRef.level.playfieldDimension) {
        gameRef.remove(this);
      }
    }
  }

  _escapeFromScreen() {
    _escaping = true;
    moveVector = Vector2(this.randomFromTo(-1, 1), this.randomFromTo(-1, 1)) * 8 * gameRef.level.pirateSpeed;
  }

  damageShip(double damage) {
    shipPower -= damage;
    if (shipPower < 0) {
      gameRef.remove(this);
      gameRef.audio.playSfx(SfxType.enemyDestroyed);
      _addExplosion();
    }
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

  Vector2 get enemyVector => Vector2(sin(pirateAngle), cos(pirateAngle));

  bool get _canChangeDirection => moveTimeout <= 0;
}
