import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:steroids/src/level_selection/levels.dart';

extension ComponentExtension on Component {
  void shake() {
    final effect = SequenceEffect([
      RotateEffect.by(0.2, EffectController(duration: 0.1, reverseDuration: 0.1, repeatCount: 2)),
      ScaleEffect.by(Vector2(1.1, 1.1), EffectController(duration: 0.1, reverseDuration: 0.1, repeatCount: 1)),
    ]);
    add(effect);
  }
}

extension PositionComponentExtension on PositionComponent {
  void keepWithinGameBounds(GameLevel level) {
    if (position.x >= level.playfieldDimension) {
      position.x = -level.playfieldDimension + 10;
    } else if (position.x <= - level.playfieldDimension) {
      position.x = level.playfieldDimension -10;
    }
    if (position.y >= level.playfieldDimension) {
      position.y = -level.playfieldDimension + 10;
    } else if (position.y <= - level.playfieldDimension) {
      position.y = level.playfieldDimension -10;
    }
  }
}