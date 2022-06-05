import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../steroids.dart';

class StationStorageGuage extends CircleComponent with HasGameRef<SteroidsLevel> {
  StationStorageGuage({
    priority: 5,
    required double radius,
  }) : super(radius: radius);

  double _maxStrokeWidth = 5;
  late double lastStrength;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = BasicPalette.magenta.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    position = Vector2((gameRef.singleStation.size.x - size.x) / 2, (gameRef.singleStation.size.y - size.y) / 2);
    lastStrength = storage;
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
  _updateStrokeWidth();
  }

  _updateStrokeWidth() {
    if (lastStrength != storage) {
      paint.strokeWidth = _maxStrokeWidth * storage / gameRef.level.winStorageTarget;
      lastStrength = storage;
    }
  }

  double get storage => gameRef.singleStation.stationStorage.value;
}
