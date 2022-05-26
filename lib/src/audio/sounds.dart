// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.asteroid:
      return const [
      ];
    case SfxType.wssh:
      return const [
      ];
    case SfxType.buttonTap:
      return const [
      ];
    case SfxType.congrats:
      return const [
      ];
    case SfxType.erase:
      return const [
      ];
    case SfxType.swishSwish:
      return const [
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.asteroid:
      return 0.4;
    case SfxType.wssh:
      return 0.2;
    case SfxType.buttonTap:
    case SfxType.congrats:
    case SfxType.erase:
    case SfxType.swishSwish:
      return 1.0;
  }
}

enum SfxType {
  asteroid,
  wssh,
  buttonTap,
  congrats,
  erase,
  swishSwish,
}
