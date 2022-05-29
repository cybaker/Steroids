import 'package:flame/components.dart';
import 'package:steroids/src/audio/sounds.dart';

import '../steroids.dart';

class BackgroundSound extends Component with HasGameRef<SteroidsLevel> {
  BackgroundSound() : super();

  @override
  void update(double dt) {
    super.update(dt);
    backgroundBeat();
  }

  // background beats faster as level completes
  static int completionPercent = 0;

  static void levelCompletionPercent(int percent) {
    if (percent >= 0 && percent <= 100) {
      completionPercent = percent;
    }
  }

  static const int _slowInterval = 60;
  static int _frameCount = 0;
  static int _beatCount = 0;
  void backgroundBeat() {
    final interval = _slowInterval * (1 - 4*completionPercent/500);
    if (_frameCount++ >= interval) {
      _beatCount++;
      _frameCount = 0;
      gameRef.audio.playSfx(_beatCount.isEven ? SfxType.beat1 : SfxType.beat2);
    }
  }
}
