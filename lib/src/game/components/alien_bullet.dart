import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:steroids/src/game/components/polygonAsteroid.dart';

import '../player/player_component.dart';
import '../steroids.dart';

class EnemyBullet extends CircleComponent
    with HasGameRef<SteroidsLevel>,
        CollisionCallbacks {
  EnemyBullet({
    required double radius,
    required this.velocityVector,
    required this.initialPosition,
    required this.timeToLive,
  }) : super(radius: radius);

  final Vector2 velocityVector;
  final Vector2 initialPosition;
  late double timeToLive;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = BasicPalette.red.paint()
      ..style = PaintingStyle.fill;
    position = initialPosition;
    await add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    if (other is Player) hitPlayer(other);
    super.onCollision(points, other);
  }

  hitPlayer(Player player) {
    player.damageShip(gameRef.level.alienBulletDamageToPlayer);
    gameRef.remove(this);
  }

  hitAsteroid(PolygonAsteroid asteroid) {
    asteroid.hitAsteroid();
    gameRef.remove(this);
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);

    position = position + velocityVector * deltaTime;

    updateTimeToLive(deltaTime);
  }

  void updateTimeToLive(double deltaTime) {
    timeToLive -= deltaTime;
    if (timeToLive < 0.0) {
      gameRef.remove(this);
    }
  }
}