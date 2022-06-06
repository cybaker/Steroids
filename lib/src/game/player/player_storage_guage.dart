import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../steroids.dart';

class PlayerStorageGuage extends CircleComponent with HasGameRef<SteroidsLevel> {
  PlayerStorageGuage({
    priority: 5,
    required double radius,
  }) : super(radius: radius);

  double _maxStrokeWidth = 4;
  late double lastStore;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = BasicPalette.magenta.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;

    position = Vector2((gameRef.singlePlayer.size.x - size.x) / 2, (gameRef.singlePlayer.size.y - size.y) / 2);
    lastStore = storage;
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    _updateStrokeWidth();
  }

  _updateStrokeWidth() {
    if (lastStore != storage) {
      paint.strokeWidth = _maxStrokeWidth * storage / 100;
      lastStore = storage;
    }
  }

  double get storage => gameRef.singlePlayer.shipStorage.value;
}
