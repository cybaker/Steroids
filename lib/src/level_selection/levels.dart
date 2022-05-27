// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const gameLevels = [
  GameLevel(
    number: 1,
    name: 'Training',
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
    bulletFireLifetimeSecs: 0.5,
    powerRegenMultiplier: 1,
    powerupAverageSpawnTimeSec: 20,
    powerupAverageLifetimeSec: 10,
    enemyAverageSpawnTimeSec: 5,
    enemyPathChangeIntervalSec: 10,
    enemyPower: 1,
    enemySpeed: 100,
    enemyBulletSpeed: 200,
    enemyBulletLifetimeSecs: 0.6,
    // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: 'first_win',
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),
  GameLevel(
    number: 2,
    name: 'Cadet',
    difficulty: 42,
    cameraDimension: 600,
    playfieldDimension: 400,
    asteroidCount: 15,
    maxAsteroidSpeed: 1.5,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 2,
    winStorageTarget: 150,
    thrustMultiplier: 1,
    fireMultiplier: 1,
    bulletFireLifetimeSecs: 0.6,
    powerRegenMultiplier: 1,
    powerupAverageSpawnTimeSec: 15,
    powerupAverageLifetimeSec: 10,
    enemyAverageSpawnTimeSec: 20,
    enemyPathChangeIntervalSec: 8,
    enemyPower: 2,
    enemySpeed: 3,
    enemyBulletSpeed: 10,
    enemyBulletLifetimeSecs: 0.6,
  ),
  GameLevel(
    number: 3,
    name: 'Difficult',
    difficulty: 100,
    cameraDimension: 600,
    playfieldDimension: 600,
    asteroidCount: 20,
    maxAsteroidSpeed: 2,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 3,
    winStorageTarget: 300,
    thrustMultiplier: 1,
    fireMultiplier: 1,
    bulletFireLifetimeSecs: 0.7,
    powerRegenMultiplier: 1,
    powerupAverageSpawnTimeSec: 30,
    powerupAverageLifetimeSec: 10,
    enemyAverageSpawnTimeSec: 15,
    enemyPathChangeIntervalSec: 6,
    enemyPower: 3,
    enemySpeed: 4,
    enemyBulletSpeed: 10,
    enemyBulletLifetimeSecs: 0.6,
    achievementIdIOS: 'finished',
    achievementIdAndroid: 'CdfIhE96aspNWLGSQg',
  ),
];

class GameLevel {
  final int number;
  final String name;
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
  final double bulletFireLifetimeSecs;

  final double powerupAverageSpawnTimeSec;
  final double powerupAverageLifetimeSec;


  final double enemyAverageSpawnTimeSec;
  final double enemyPathChangeIntervalSec;
  final double enemyPower;
  final double enemySpeed;
  final double enemyBulletSpeed;
  final double enemyBulletLifetimeSecs;

  /// The achievement to unlock when the level is finished, if any.
  final String? achievementIdIOS;

  final String? achievementIdAndroid;

  bool get awardsAchievement => achievementIdAndroid != null;

  const GameLevel({
    required this.number,
    required this.name,
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
    required this.bulletFireLifetimeSecs,
    required this.powerRegenMultiplier,
    required this.thrustMultiplier,

    required this.powerupAverageSpawnTimeSec,
    required this.powerupAverageLifetimeSec,

    required this.enemyAverageSpawnTimeSec,
    required this.enemyPathChangeIntervalSec,
    required this.enemyPower,
    required this.enemySpeed,
    required this.enemyBulletSpeed,
    required this.enemyBulletLifetimeSecs,

    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
