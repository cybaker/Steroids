import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../audio/sounds.dart';
import '../components/station_power_guage.dart';
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

    sprite = await gameRef.loadSprite('station_B.png');

    add(StationPowerGuage(radius: 6 * size.x / 10));
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += rotationSpeed * dt;
    if (gameRef.audio.settings?.soundMuted.value == false && gameRef.audio.settings?.backgroundMusicOn.value == true) {
      backgroundBeat();
    }
  }

  void addStorage(double material) {
    debugPrint('Station receiving $material');
    stationStorage.value += material;
    gameRef.audio.playSfx(SfxType.stationStore);
    var percent = stationStorage.value * 100 / gameRef.level.winStorageTarget;
    if (percent >= 0 && percent <= 100) {
      completionPercent = percent.toInt();
    }
  }

  // background beats faster as level completes
  int completionPercent = 0;

  static const int _slowInterval = 60;
  int _frameCount = 0;
  int _beatCount = 0;

  void backgroundBeat() {
    final interval = _slowInterval * (1 - 4 * completionPercent / 500);
    if (_frameCount++ >= interval) {
      _beatCount++;
      _frameCount = 0;
      gameRef.audio.playSfxBackground(_beatCount.isEven ? SfxType.beat1 : SfxType.beat2);
    }
  }
}
