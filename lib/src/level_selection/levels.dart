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
    playfieldDimension: 600,
    asteroidCount: 20,
    maxAsteroidSpeed: 2,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
  ),
  GameLevel(
    number: 3,
    difficulty: 100,
    cameraDimension: 600,
    playfieldDimension: 600,
    asteroidCount: 30,
    maxAsteroidSpeed: 3,
    maxAsteroidSize: 20,
    minAsteroidSize: 5,
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
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
            (achievementIdAndroid != null && achievementIdIOS != null) ||
                (achievementIdAndroid == null && achievementIdIOS == null),
            'Either both iOS and Android achievement ID must be provided, '
            'or none');
}
