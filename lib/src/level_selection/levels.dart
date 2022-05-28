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
    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.5,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 1,
    powerupAverageSpawnTimeSec: 20,
    powerupAverageLifetimeSec: 10,
    enemyAverageSpawnTimeSec: 60,
    enemyPathChangeIntervalSec: 10,
    enemyPower: 1,
    enemySpeed: 20,
    enemyBulletSpeed: 200,
    enemyBulletDamageToPlayer: 1,
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
    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.8,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 1,
    powerupAverageSpawnTimeSec: 15,
    powerupAverageLifetimeSec: 10,
    enemyAverageSpawnTimeSec: 30,
    enemyPathChangeIntervalSec: 8,
    enemyPower: 2,
    enemySpeed: 30,
    enemyBulletSpeed: 200,
    enemyBulletDamageToPlayer: 1,
    enemyBulletLifetimeSecs: 0.8,
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
    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 1,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 1,
    powerupAverageSpawnTimeSec: 30,
    powerupAverageLifetimeSec: 10,
    enemyAverageSpawnTimeSec: 20,
    enemyPathChangeIntervalSec: 6,
    enemyPower: 3,
    enemySpeed: 44,
    enemyBulletSpeed: 300,
    enemyBulletDamageToPlayer: 1,
    enemyBulletLifetimeSecs: 1,
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

  final double playerThrustMultiplier;
  final double playerFireMultiplier;
  final double playerPowerRegenMultiplier;
  final double playerBulletFireLifetimeSecs;
  final double playerBulletDamageToEnemy;

  final double powerupAverageSpawnTimeSec;
  final double powerupAverageLifetimeSec;


  final double enemyAverageSpawnTimeSec;
  final double enemyPathChangeIntervalSec;
  final double enemyPower;
  final double enemySpeed;
  final double enemyBulletSpeed;
  final double enemyBulletLifetimeSecs;
  final double enemyBulletDamageToPlayer;

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
    required this.playerFireMultiplier,
    required this.playerBulletFireLifetimeSecs,
    required this.playerPowerRegenMultiplier,
    required this.playerThrustMultiplier,
    required this.playerBulletDamageToEnemy,

    required this.powerupAverageSpawnTimeSec,
    required this.powerupAverageLifetimeSec,

    required this.enemyAverageSpawnTimeSec,
    required this.enemyPathChangeIntervalSec,
    required this.enemyPower,
    required this.enemySpeed,
    required this.enemyBulletSpeed,
    required this.enemyBulletLifetimeSecs,
    required this.enemyBulletDamageToPlayer,

    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
