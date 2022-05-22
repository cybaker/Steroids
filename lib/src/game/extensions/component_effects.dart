import 'package:flame/components.dart';
import 'package:flame/effects.dart';

extension ComponentExtension on Component {
  void shake() {
    final effect = SequenceEffect([
      RotateEffect.by(0.2, EffectController(duration: 0.1, reverseDuration: 0.1, repeatCount: 2)),
      ScaleEffect.by(Vector2(1.1, 1.1), EffectController(duration: 0.1, reverseDuration: 0.1, repeatCount: 1)),
    ]);
    add(effect);
  }
}