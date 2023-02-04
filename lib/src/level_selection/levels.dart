// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const gameLevels = [
  GameLevel(
    number: 1,
    name: 'Asteroids',
    difficulty: 5,
    cameraDimension: 600,
    playfieldDimension: 300,
    winStorageTarget: 100,

    asteroidCount: 10,
    maxAsteroidSpeed: 30,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 1,

    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.5,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 5,

    powerupAverageSpawnTimeSec: 20,
    powerupAverageLifetimeSec: 10,

    alienAverageSpawnTimeSec: 1000,
    alienPathChangeIntervalSec: 5,
    alienPower: 0.9,
    alienSpeed: 20,
    alienBulletSpeed: 200,
    alienBulletDamageToPlayer: 1,
    alienBulletLifetimeSecs: 0.6,

    pirateAverageSpawnTimeSec: 1000,
    piratePathChangeIntervalSec: 5,
    piratePower: 0.9,
    pirateSpeed: 20,

    // TODO: When ready, change these achievement IDs.
    // You configure this in App Store Connect.
    achievementIdIOS: 'first_win',
    // You get this string when you configure an achievement in Play Console.
    achievementIdAndroid: 'NhkIwB69ejkMAOOLDb',
  ),

  GameLevel(
    number: 2,
    name: 'Pirates',
    difficulty: 5,
    cameraDimension: 600,
    playfieldDimension: 300,
    winStorageTarget: 100,

    asteroidCount: 0,
    maxAsteroidSpeed: 30,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 1,

    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.5,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 5,

    powerupAverageSpawnTimeSec: 20,
    powerupAverageLifetimeSec: 10,

    alienAverageSpawnTimeSec: 1000,
    alienPathChangeIntervalSec: 5,
    alienPower: 0.9,
    alienSpeed: 20,
    alienBulletSpeed: 200,
    alienBulletDamageToPlayer: 1,
    alienBulletLifetimeSecs: 0.6,

    pirateAverageSpawnTimeSec: 4,
    piratePathChangeIntervalSec: 3,
    piratePower: 0.9,
    pirateSpeed: 50,
  ),

  GameLevel(
    number: 3,
    name: 'Aliens',
    difficulty: 5,
    cameraDimension: 600,
    playfieldDimension: 300,
    winStorageTarget: 100,

    asteroidCount: 1,
    maxAsteroidSpeed: 30,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 1,

    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.5,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 5,

    powerupAverageSpawnTimeSec: 20,
    powerupAverageLifetimeSec: 10,

    alienAverageSpawnTimeSec: 5,
    alienPathChangeIntervalSec: 4,
    alienPower: 0.9,
    alienSpeed: 50,
    alienBulletSpeed: 200,
    alienBulletDamageToPlayer: 2,
    alienBulletLifetimeSecs: 0.6,

    pirateAverageSpawnTimeSec: 1000,
    piratePathChangeIntervalSec: 5,
    piratePower: 0.9,
    pirateSpeed: 50,
  ),

  GameLevel(
    number: 4,
    name: 'Asteroids and Pirates',
    difficulty: 42,
    cameraDimension: 600,
    playfieldDimension: 400,
    winStorageTarget: 150,

    asteroidCount: 15,
    maxAsteroidSpeed: 45,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 2,

    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.8,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 4,

    powerupAverageSpawnTimeSec: 15,
    powerupAverageLifetimeSec: 10,

    alienAverageSpawnTimeSec: 1000,
    alienPathChangeIntervalSec: 8,
    alienPower: 2,
    alienSpeed: 30,
    alienBulletSpeed: 200,
    alienBulletDamageToPlayer: 1,
    alienBulletLifetimeSecs: 0.8,

    pirateAverageSpawnTimeSec: 20,
    piratePathChangeIntervalSec: 3,
    piratePower: 1.9,
    pirateSpeed: 50,
  ),

  GameLevel(
    number: 5,
    name: 'Asteroids and Aliens',
    difficulty: 42,
    cameraDimension: 600,
    playfieldDimension: 400,
    winStorageTarget: 150,

    asteroidCount: 15,
    maxAsteroidSpeed: 45,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 2,

    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.8,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 4,

    powerupAverageSpawnTimeSec: 15,
    powerupAverageLifetimeSec: 10,

    alienAverageSpawnTimeSec: 1000,
    alienPathChangeIntervalSec: 8,
    alienPower: 2,
    alienSpeed: 30,
    alienBulletSpeed: 200,
    alienBulletDamageToPlayer: 1,
    alienBulletLifetimeSecs: 0.8,

    pirateAverageSpawnTimeSec: 20,
    piratePathChangeIntervalSec: 3,
    piratePower: 1.9,
    pirateSpeed: 50,
  ),

  GameLevel(
    number: 6,
    name: 'Asteroids and Pirates and Aliens',
    difficulty: 42,
    cameraDimension: 600,
    playfieldDimension: 400,
    winStorageTarget: 200,

    asteroidCount: 15,
    maxAsteroidSpeed: 45,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 2,

    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 0.8,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 2,

    powerupAverageSpawnTimeSec: 15,
    powerupAverageLifetimeSec: 10,

    alienAverageSpawnTimeSec: 30,
    alienPathChangeIntervalSec: 5,
    alienPower: 2,
    alienSpeed: 60,
    alienBulletSpeed: 200,
    alienBulletDamageToPlayer: 1,
    alienBulletLifetimeSecs: 0.8,

    pirateAverageSpawnTimeSec: 20,
    piratePathChangeIntervalSec: 3,
    piratePower: 1.9,
    pirateSpeed: 60,
  ),

  GameLevel(
    number: 7,
    name: 'Challenge',
    difficulty: 100,
    cameraDimension: 600,
    playfieldDimension: 600,

    asteroidCount: 30,
    maxAsteroidSpeed: 60,
    maxAsteroidSize: 30,
    minAsteroidSize: 5,
    asteroidDamageMultiplier: 5,

    winStorageTarget: 200,

    playerThrustMultiplier: 1,
    playerFireMultiplier: 1,
    playerBulletFireLifetimeSecs: 1,
    playerBulletDamageToEnemy: 1,
    playerPowerRegenMultiplier: 1,

    powerupAverageSpawnTimeSec: 30,
    powerupAverageLifetimeSec: 10,

    alienAverageSpawnTimeSec: 10,
    alienPathChangeIntervalSec: 6,
    alienPower: 3,
    alienSpeed: 60,
    alienBulletSpeed: 300,
    alienBulletDamageToPlayer: 2,
    alienBulletLifetimeSecs: 1,

    pirateAverageSpawnTimeSec: 20,
    piratePathChangeIntervalSec: 5,
    piratePower: 1.9,
    pirateSpeed: 100,

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

  final double alienAverageSpawnTimeSec;
  final double alienPathChangeIntervalSec;
  final double alienPower;
  final double alienSpeed;
  final double alienBulletSpeed;
  final double alienBulletLifetimeSecs;
  final double alienBulletDamageToPlayer;

  final double pirateAverageSpawnTimeSec;
  final double piratePathChangeIntervalSec;
  final double piratePower;
  final double pirateSpeed;

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

    required this.alienAverageSpawnTimeSec,
    required this.alienPathChangeIntervalSec,
    required this.alienPower,
    required this.alienSpeed,
    required this.alienBulletSpeed,
    required this.alienBulletLifetimeSecs,
    required this.alienBulletDamageToPlayer,

    required this.pirateAverageSpawnTimeSec,
    required this.piratePathChangeIntervalSec,
    required this.piratePower,
    required this.pirateSpeed,

    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
