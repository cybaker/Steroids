// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const gameLevels = [
  GameLevel(
    number: 1,
    difficulty: 5,
    cameraDimension: 600,
    playfieldDimension: 300,
    asteroidCount: 10,
    maxAsteroidSpeed: 1,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 1,
    winStorageTarget: 100,
    thrustMultiplier: 1,
    fireMultiplier: 1,
    powerRegenMultiplier: 1,
    // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: 'first_win',
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  GameLevel(
    number: 2,
    difficulty: 42,
    cameraDimension: 600,
    playfieldDimension: 400,
    asteroidCount: 20,
    maxAsteroidSpeed: 1.5,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 1,
    winStorageTarget: 150,
    thrustMultiplier: 1,
    fireMultiplier: 1,
    powerRegenMultiplier: 1,
  ),
  GameLevel(
    number: 3,
    difficulty: 100,
    cameraDimension: 600,
    playfieldDimension: 600,
    asteroidCount: 30,
    maxAsteroidSpeed: 2,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 1,
    winStorageTarget: 200,
    thrustMultiplier: 1,
    fireMultiplier: 1,
    powerRegenMultiplier: 1,
    achievementIdIOS: 'finished',
    achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
  ),
];

class GameLevel {
  final int number;

  final int difficulty;

  final int cameraDimension;
  final int playfieldDimension;

  final int asteroidCount;
  final double maxAsteroidSpeed;
  final double maxAsteroidSize;
  final double minAsteroidSize;
  final double asteroidDamageMultiplier;

  final double winStorageTarget;

  final double thrustMultiplier;
  final double fireMultiplier;
  final double powerRegenMultiplier;

  /// The achievement to unlock when the level is finished, if any.
  final String? achievementIdIOS;

  final String? achievementIdAndroid;

  bool get awardsAchievement => achievementIdAndroid != null;

  const GameLevel({
    required this.number,
    required this.difficulty,
    required this.cameraDimension,
    required this.playfieldDimension,

    required this.asteroidCount,
    required this.maxAsteroidSpeed,
    required this.maxAsteroidSize,
    required this.minAsteroidSize,
    required this.asteroidDamageMultiplier,

    required this.winStorageTarget,
    required this.fireMultiplier,
    required this.powerRegenMultiplier,
    required this.thrustMultiplier,

    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
