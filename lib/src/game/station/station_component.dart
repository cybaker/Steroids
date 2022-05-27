import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../util/sounds.dart';
import '../steroids.dart';

///
/// Space Station where player deposits asteroid material
///
class Station extends SpriteComponent with HasGameRef<SteroidsLevel> {
  Station()
      : super(
          priority: 2,
          size: Vector2(40, 40),
        );

  final double rotationSpeed = 1;

  ValueNotifier<double> stationStorage = ValueNotifier<double>(0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await add(RectangleHitbox());

    anchor = Anchor.center;

    sprite = await gameRef.loadSprite('station_C.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += rotationSpeed * dt;
  }

  void addStorage(double material) {
    debugPrint('Station receiving $material');
    stationStorage.value += material;
    Sounds.playStationReceiveStorage();
    var completionPercent = stationStorage.value * 100 / gameRef.level.winStorageTarget;
    Sounds.levelCompletionPercent(completionPercent.toInt());
  }
}
