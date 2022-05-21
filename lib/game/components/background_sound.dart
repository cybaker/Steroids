import 'dart:math';
import 'dart:ui';

import 'package:Roids/game/model/asteroid_factory.dart';
import 'package:Roids/game/roids.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';

class BackgroundSound extends Component with HasGameRef<Roids> {
  BackgroundSound({required this.level}) : super();

  final int level;

  final int _beatInterval = 60;
  int _frameCount = 0;
  int _beatCount = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await FlameAudio.audioCache.loadAll(['beat1.wav', 'beat2.wav']);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_frameCount++ % _beatInterval == 0) {
      _beatCount++;
      FlameAudio.audioCache.play(_beatCount.isEven ? 'beat1.wav' : 'beat2.wav');
    }
  }
}
