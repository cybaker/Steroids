
import 'dart:math';

import 'package:flame/components.dart';
import '../components/powerups.dart';

import '../steroids.dart';

class PowerupFactory extends Component
    with HasGameRef<SteroidsLevel> {
  PowerupFactory() : super(priority: 4);

  double futureSpawnTime = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    futureSpawnTime = randomSpawnTime;
  }

  @override
  void update(double dt) {
    futureSpawnTime -= dt;
    if(futureSpawnTime < 0) spawnRandomPowerup();
  }

  void spawnRandomPowerup() {
    gameRef.add( Random().nextBool() ? FasterShot(gameRef.level) : Shield(gameRef.level));
    futureSpawnTime = randomSpawnTime;
  }

  double get randomSpawnTime => gameRef.level.powerupAverageSpawnTimeSec*(1/2 + Random().nextDouble());
}

