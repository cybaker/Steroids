
import 'dart:math';

import 'package:flame/components.dart';
import '../../level_selection/levels.dart';
import '../components/powerups.dart';

import '../steroids.dart';

class PowerupFactory extends Component
    with HasGameRef<SteroidsLevel> {
  PowerupFactory({required this.level}) : super(priority: 4);

  final GameLevel level;
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
    gameRef.add( Random().nextBool() ? FasterShot(level) : Shield(level));
    futureSpawnTime = randomSpawnTime;
  }

  double get randomSpawnTime => level.powerupAverageSpawnTimeSec*(1/2 + Random().nextDouble());
}

