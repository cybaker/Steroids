import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../station/station.dart';
import '../steroids.dart';

class StationPowerGuage extends CircleComponent with HasGameRef<SteroidsLevel> {
  StationPowerGuage({
    priority: 5,
    required double radius,
  }) : super(radius: radius);

  double _maxStrokeWidth = 5;
  late double lastStrength;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = BasicPalette.blue.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    position = Vector2(0, 0);
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

  double get storage => (parent as Station).stationStorage.value;
}
