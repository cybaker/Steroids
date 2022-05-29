import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../../level_selection/levels.dart';
import '../steroids.dart';

class GameEdge extends PolygonComponent with HasGameRef<SteroidsLevel>, CollisionCallbacks {
  final GameLevel level;

  GameEdge({required this.level})
      : super([
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
      ..strokeWidth = 20;
    await add(PolygonHitbox(vertices));
    gameRef.add(TimerComponent(period: 1, repeat: true, onTick: keepComponentsInBounds));
  }

  void keepComponentsInBounds() {
    // debugPrint('Updating Component boundaries');
    for (final child in gameRef.children) {
      if (child is PositionComponent && !(child is GameEdge)) {
        child.keepWithinGameBounds(gameRef.level);
      }
    }
  }
}
