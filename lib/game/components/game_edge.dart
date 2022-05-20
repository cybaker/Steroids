import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../roids.dart';

class GameEdge extends PolygonComponent
    with HasGameRef<Roids>,
        CollisionCallbacks  {
  GameEdge() : super([
    Vector2(Roids.fieldSize, Roids.fieldSize),
    Vector2(Roids.fieldSize, -Roids.fieldSize),
    Vector2(-Roids.fieldSize, -Roids.fieldSize),
    Vector2(-Roids.fieldSize, Roids.fieldSize),
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
    var offset = Roids.fieldSize - 20;
    if (other.position.x.abs() >= Roids.fieldSize) {
      other.position.x = other.position.x > 0 ? -offset : offset;
    } else if (other.position.y.abs() >= Roids.fieldSize) { // y must be hitting
      other.position.y = other.position.y > 0 ? -offset : offset;
    }
    super.onCollision(intersectionPoints, other);
  }
}