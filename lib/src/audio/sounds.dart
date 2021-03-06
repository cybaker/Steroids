// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.bullet:
      return const [
        'fire.wav',
      ];
    case SfxType.thrust:
      return const [
        'thrust.wav',
      ];
    case SfxType.buttonTap:
    case SfxType.powerup:
      return const [
        'extraShip.wav',
      ];
    case SfxType.stationStore:
      return const [
        'saucerBig.wav',
      ];
    case SfxType.beat1:
      return const [
        'beat1.wav',
      ];
    case SfxType.beat2:
      return const [
        'beat2.wav',
      ];
    case SfxType.asteroid:
      return const [
        'bangLarge.wav',
        'bangMedium.wav',
      ];
    case SfxType.playerStore:
    case SfxType.resourceScooped:
      return const [
        'saucerSmall.wav',
      ];
    case SfxType.enemyDestroyed:
      return const [
        'bangSmall.wav',
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.bullet:
    case SfxType.powerup:
    case SfxType.buttonTap:
      return 0.4;
    case SfxType.thrust:
      return 1.0;
    case SfxType.stationStore:
    case SfxType.beat1:
    case SfxType.beat2:
    case SfxType.asteroid:
    case SfxType.resourceScooped:
    case SfxType.playerStore:
    case SfxType.enemyDestroyed:
      return 0.8;
  }
}

enum SfxType {
  buttonTap,
  bullet,
  thrust,
  stationStore,
  beat1,
  beat2,
  asteroid,
  resourceScooped,
  powerup,
  enemyDestroyed,
  playerStore,
}
