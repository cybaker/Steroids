
import 'dart:math';

import 'package:flame/components.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';
import '../components/alien.dart';

import '../player/player.dart';
import '../steroids.dart';

class AlienFactory extends Component
    with HasGameRef<SteroidsLevel> {
  AlienFactory({required this.player}) : super(priority: 5);

  final Player player;

  double futureSpawnTime = 0;

  double get randomSpawnTime => gameRef.level.alienAverageSpawnTimeSec*(0.5 + Random().nextDouble());

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    futureSpawnTime = randomSpawnTime;
  }

  @override
  void update(double dt) {
    futureSpawnTime -= dt;
    if(futureSpawnTime < 0) spawnRandomEnemy();
  }

  void spawnRandomEnemy() {
    gameRef.add(makeRandomEnemy());
    futureSpawnTime = randomSpawnTime;
  }

  PositionComponent makeRandomEnemy() {
    var enemy = Alien(player: player);
    enemy.setRandomPositionBetween(gameRef.level.playfieldDimension.toDouble(), 6*gameRef.level.playfieldDimension/8);
    return enemy;
  }
}

