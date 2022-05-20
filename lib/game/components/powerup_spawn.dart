
import 'dart:math';

import 'package:flame/components.dart';
import 'package:Roids/game/components/powerup.dart';

import '../roids.dart';

class Powerups extends Component
    with HasGameRef<Roids> {
  Powerups() : super(priority: 4);

  double timeToSpawn = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    timeToSpawn = randomFutureTime();
  }

  @override
  void update(double dt) {
    timeToSpawn -= dt;
    if(timeToSpawn < 0) spawnPowerup();
  }

  void spawnPowerup() {
    gameRef.add( Random().nextBool() ? MultiShot() : Nuke());
    timeToSpawn = randomFutureTime();
  }

  double randomFutureTime() {
    return 10 + Random().nextDouble()*10;
  }
}

