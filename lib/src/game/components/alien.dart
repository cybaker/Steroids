import 'package:flame/components.dart';

import '../../audio/sounds.dart';
import '../player/player.dart';
import 'alien_bullet.dart';
import 'enemy.dart';

class Alien extends Enemy {
  Alien({required this.player}) : super(player: player);

  final Player player;

  double fireTimeout = 0;
  double scaleFireTimeout = 1;

  @override
  void setupEnemyVariables() {
    shipPower = gameRef.level.alienPower;
    speed = gameRef.level.alienSpeed;
    moveTimeoutSetting = gameRef.level.alienPathChangeIntervalSec;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _calculateBullets(dt, playerAngle);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      gameRef.remove(this);
    }
    super.onCollision(intersectionPoints, other);
  }

  void _calculateBullets(double dt, double playerAngle) {
    fireTimeout -= dt;
    if (_canFireBullet) _fireBullet(playerAngle);
  }

  bool get _canFireBullet => fireTimeout <= 0;

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
