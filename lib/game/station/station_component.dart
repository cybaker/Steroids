import 'package:Roids/game/model/Sounds.dart';
import 'package:Roids/game/roids.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

///
/// Space Station where player drops off asteroid material
class Station extends SpriteComponent with HasGameRef<Roids> {
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
