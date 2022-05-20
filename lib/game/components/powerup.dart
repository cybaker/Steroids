import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../roids.dart';

class PowerUp extends SpriteComponent
    with HasGameRef<Roids>,
        CollisionCallbacks {
  PowerUp({
    required this.assetName,
}) : super(priority: 4, size: Vector2(20, 20),);

  final String assetName;

  double powerDownTime = 10;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    sprite = await gameRef.loadSprite('multi_fire.png');

    position = Vector2(
      Random().nextDouble()*200-100,
      Random().nextDouble()*200-100,);

    anchor = Anchor.center;

    debugPrint('Spawning $assetName at position $position');
  }

  @override
  void update(double dt) {
    super.update(dt);
    powerDownTime -= dt;
    if (powerDownTime < 0) {
      gameRef.remove(this);
    }
  }
}

class MultiShot extends PowerUp{
  MultiShot() : super(assetName: 'multi_fire.png');
}

class Nuke extends PowerUp{
  Nuke() : super(assetName: 'nuke.png');
}
