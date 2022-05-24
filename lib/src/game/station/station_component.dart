import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

import '../model/sounds.dart';
import '../steroids.dart';

///
/// Space Station where player drops off asteroid material
class Station extends SpriteComponent with HasGameRef<SteroidsLevel> {
  Station()
      : super(
          priority: 2,
          size: Vector2(40, 40),
        );

  final double speed = 1;

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
    angle += speed * dt;
  }

  void addStorage(double material) {
    debugPrint('Station receiving $material');
    stationStorage.value += material;
    Sounds.playStationReceiveStorage();

    //TODO level completion goes somewhere else
    Sounds.levelCompletionPercent(stationStorage.value.toInt());
  }
}
