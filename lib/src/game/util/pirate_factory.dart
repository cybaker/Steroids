
import 'dart:math';

import 'package:flame/components.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../components/pirate.dart';
import '../player/player_component.dart';
import '../steroids.dart';

class PirateFactory extends Component
    with HasGameRef<SteroidsLevel> {
  PirateFactory({required this.player}) : super(priority: 5);

  final Player player;

  double futureSpawnTime = 0;

  double get randomSpawnTime => gameRef.level.pirateAverageSpawnTimeSec*(0.5 + Random().nextDouble());

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    futureSpawnTime = randomSpawnTime;
  }

  @override
  void update(double dt) {
    futureSpawnTime -= dt;
    if(futureSpawnTime < 0) spawnRandomPirate();
  }

  void spawnRandomPirate() {
    gameRef.add(makeRandomPirate());
    futureSpawnTime = randomSpawnTime;
  }

  PositionComponent makeRandomPirate() {
    var pirate = Pirate(player: player);
    pirate.setRandomPositionBetween(gameRef.level.playfieldDimension.toDouble(), 6*gameRef.level.playfieldDimension/8);
    return pirate;
  }
}

