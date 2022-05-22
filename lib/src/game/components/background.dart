import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';

import '../steroids.dart';

class Background extends SpriteComponent
    with HasGameRef<Steroids> {
  Background()
      : super(
          size: Vector2(600, 200),
          priority: 1,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;

    var _stars = await gameRef.loadParallax(
      [
        ParallaxImageData('stars1.png'),
        ParallaxImageData('stars2.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -5),
      velocityMultiplierDelta: Vector2(0, 1.5),
    );

    sprite = await gameRef.loadSprite('background.png');
  }
}
