import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import '../../level_selection/levels.dart';
import '../steroids.dart';

class GameEdge extends PolygonComponent
    with HasGameRef<SteroidsLevel>,
        CollisionCallbacks  {
  final GameLevel level;

  GameEdge({required this.level}) : super([
    Vector2(level.playfieldDimension.toDouble(), level.playfieldDimension.toDouble()),
    Vector2(level.playfieldDimension.toDouble(), -level.playfieldDimension.toDouble()),
    Vector2(-level.playfieldDimension.toDouble(), -level.playfieldDimension.toDouble()),
    Vector2(-level.playfieldDimension.toDouble(), level.playfieldDimension.toDouble()),
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
    var offset = level.playfieldDimension.toDouble() - 20;
    if (other.position.x.abs() >= level.playfieldDimension.toDouble()) {
      other.position.x = other.position.x > 0 ? -offset : offset;
    } else if (other.position.y.abs() >= level.playfieldDimension.toDouble()) { // y must be hitting
      other.position.y = other.position.y > 0 ? -offset : offset;
    }
    super.onCollision(intersectionPoints, other);
  }
}