import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:steroids/src/audio/sounds.dart';

import '../player/player_component.dart';
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

  static const firePowerConsumption = 2;
  static const thrustPowerConsumption = 0.1;

  late double shipPower = gameRef.level.piratePower;

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
    move(dt, pirateAngle);
  }

  void move(double dt, double playerAngle) {
    moveTimeout -= dt;
    if (_canChangeDirection) {
      moveVector = enemyVector * gameRef.level.pirateSpeed;
      moveTimeout = gameRef.level.piratePathChangeIntervalSec;
    }
    position = position + moveVector * dt;
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
    }
  }

  double get enemyAngle => atan2(player.position.x - this.position.x, player.position.y - this.position.y);

  Vector2 get enemyVector => Vector2(sin(pirateAngle), cos(pirateAngle));

  bool get _canChangeDirection => moveTimeout <= 0;
}
