import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../steroids.dart';

class GameEdge extends PolygonComponent
    with HasGameRef<Steroids>,
        CollisionCallbacks  {
  GameEdge() : super([
    Vector2(Steroids.fieldSize, Steroids.fieldSize),
    Vector2(Steroids.fieldSize, -Steroids.fieldSize),
    Vector2(-Steroids.fieldSize, -Steroids.fieldSize),
    Vector2(-Steroids.fieldSize, Steroids.fieldSize),
  ]);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    paint = BasicPalette.red.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    await add(PolygonHitbox(vertices));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // debugPrint('Edge Collided with $other');
    var offset = Steroids.fieldSize - 20;
    if (other.position.x.abs() >= Steroids.fieldSize) {
      other.position.x = other.position.x > 0 ? -offset : offset;
    } else if (other.position.y.abs() >= Steroids.fieldSize) { // y must be hitting
      other.position.y = other.position.y > 0 ? -offset : offset;
    }
    super.onCollision(intersectionPoints, other);
  }
}