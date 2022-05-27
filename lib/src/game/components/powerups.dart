import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../steroids.dart';

class PowerUp extends SpriteComponent
    with HasGameRef<SteroidsLevel>,
        CollisionCallbacks {
  PowerUp({
    required this.assetName,
  }) : super(priority: 4, size: Vector2(20, 20),);

  final String assetName;

  late double powerupLifeTime = gameRef.level.powerupAverageLifetimeSec;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    sprite = await gameRef.loadSprite(assetName);

    var dimension = gameRef.level.playfieldDimension / 3;
    this.setRandomPositionInside(dimension);

    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    powerupLifeTime -= dt;
    if (powerupLifeTime < 0) {
      gameRef.remove(this);
    }
  }
}

class FasterShot extends PowerUp{
  FasterShot(level) : super(assetName: 'multi_fire.png');
}

class Shield extends PowerUp{
  Shield(level) : super(assetName: 'nuke.png');
}
