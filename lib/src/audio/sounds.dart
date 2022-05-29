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
        'bangSmall.wav',
        'bangMedium.wav',
      ];
    case SfxType.playerStore:
      return const [
        'saucerSmall.wav',
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.bullet:
      return 0.4;
    case SfxType.thrust:
      return 1.0;
    case SfxType.buttonTap:
    case SfxType.stationStore:
    case SfxType.beat1:
    case SfxType.beat2:
    case SfxType.asteroid:
    case SfxType.playerStore:
      return 1.0;
  }
}

enum SfxType {
  bullet,
  thrust,
  buttonTap,
  stationStore,
  beat1,
  beat2,
  asteroid,
  playerStore,
}
