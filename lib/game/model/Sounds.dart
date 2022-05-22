import 'dart:async';
import 'dart:convert';

import 'package:Roids/game/model/asteroid_factory.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';

class Sounds {
  Sounds({required this.level});

  final int level;

  Future<void> init() async {
    final assets = await rootBundle.loadString('AssetManifest.json');
    var json = jsonDecode(assets) as Map<String, dynamic>;
    final List<String> soundFiles = json.keys.where((element) => element.endsWith('.wav')).toList();

    await FlameAudio.audioCache.loadAll(soundFiles);
  }

  static void playAsteroidSound(Vector2 size) {
    if (size.x < AsteroidFactory.smallAsteroidMaxSize) {
      FlameAudio.audioCache.play('bangSmall.wav');
    } else {
      FlameAudio.audioCache.play('bangLarge.wav');
    }
  }

  static void playStationReceiveStorage() {
    FlameAudio.audioCache.play('saucerBig.wav');
  }

  static int thrustCount = 0; // just throttling the thrust playing not every frame
  static void playPlayerThrustSound() {
    if (thrustCount++ % 10 == 0) {
      FlameAudio.audioCache.play('thrust.wav');
    }
  }

  static void playBulletSound() {
    FlameAudio.audioCache.play('fire.wav');
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
  static void backgroundBeat() {
    final interval = _slowInterval * (1 - 4/5*completionPercent/100);
    if (_frameCount++ >= interval) {
      _beatCount++;
      _frameCount = 0;
      FlameAudio.audioCache.play(_beatCount.isEven ? 'beat1.wav' : 'beat2.wav');
    }
  }
}
