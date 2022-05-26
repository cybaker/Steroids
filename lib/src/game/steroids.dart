import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../level_selection/levels.dart';
import 'components/background_sound.dart';
import 'components/game_edge.dart';
import 'widgets/powerup_factory.dart';
import 'components/stars_parallax.dart';
import 'widgets/asteroid_factory.dart';
import 'player/player_component.dart';
import 'station/station_component.dart';

final Map<LogicalKeyboardKey, LogicalKeyboardKey> playersKeys =
  {
    LogicalKeyboardKey.arrowUp: LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown: LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft: LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight: LogicalKeyboardKey.arrowRight,
  };

class SteroidsLevel extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  SteroidsLevel({required this.level});

  final GameLevel level;

  late Set<LogicalKeyboardKey> pressedKeySet;
  bool isGameOver = false;

  late Player singlePlayer = Player(level: level); // Global only one player
  late Station singleStation = Station(level: level); // Global only one player

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    final Vector2 resolution = Vector2(level.cameraDimension.toDouble(), level.cameraDimension.toDouble());
    pressedKeySet = {};

    camera.viewport = FixedResolutionViewport(
      Vector2(resolution.x, resolution.y),
    );

    final asteroidFactory = AsteroidFactory();

    await add(StarsParallax());

    await add(GameEdge(level: level));
    await add(BackgroundSound(level: 1));

    await add(singlePlayer..y = 40);

    await add(
      singleStation
        ..x = 0
        ..y = 0,
    );
    await addAll(asteroidFactory.makeAsteroids(level));
    await add(PowerupFactory(level: level));

    camera.followComponent(singlePlayer);
  }

  /*
    This allows continuous key pressing for a real keyboard
   */
  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    super.onKeyEvent(event, keysPressed);
    if (!isLoaded || isGameOver) {
      return KeyEventResult.ignored;
    }

    pressedKeySet.clear();
    for (var key in keysPressed) {
      pressedKeySet.add(key);
    }
    return KeyEventResult.handled;
  }
}
