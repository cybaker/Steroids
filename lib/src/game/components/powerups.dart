import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../../level_selection/levels.dart';
import '../steroids.dart';

class PowerUp extends SpriteComponent
    with HasGameRef<SteroidsLevel>,
        CollisionCallbacks {
  PowerUp({
    required this.assetName,
    required this.level,
  }) : super(priority: 4, size: Vector2(20, 20),);

  final String assetName;
  final GameLevel level;

  late double powerupLifeTime = level.powerupAverageLifetimeSec;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(CircleHitbox());

    sprite = await gameRef.loadSprite(assetName);

    var dimension = level.playfieldDimension / 3;
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
  FasterShot(level) : super(assetName: 'multi_fire.png', level: level);
}

class Shield extends PowerUp{
  Shield(level) : super(assetName: 'nuke.png', level: level);
}
