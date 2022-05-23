import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../level_selection/levels.dart';
import 'components/background_sound.dart';
import 'components/game_edge.dart';
import 'components/powerup_spawn.dart';
import 'components/stars_parallax.dart';
import 'model/asteroid_factory.dart';
import 'player/player_component.dart';
import 'station/station_component.dart';

final Map<LogicalKeyboardKey, LogicalKeyboardKey> playersKeys =
  {
    LogicalKeyboardKey.arrowUp: LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown: LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft: LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight: LogicalKeyboardKey.arrowRight,
  };

// TODO gh_pages to deploy web version
// TODO Level logic so players can play a campaign.
// TODO Player and Station view looks
// TODO GameBalance - pass level number to components
// TODO upgrades like faster rotation, faster shots, shorter shot recharging, etc
// TODO Disruptor powerup - like flechette, shatters all roids down to smallest on hit

class SteroidsLevel extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  SteroidsLevel({required this.level});

  final GameLevel level;

  late final Player player;
  late Set<LogicalKeyboardKey> pressedKeySet;
  bool isGameOver = false;

  static final singlePlayer = Player(); // Global only one player
  static final singleStation = Station(); // Global only one player

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

    await add(player = singlePlayer..y = 40);

    await add(
      singleStation
        ..x = 0
        ..y = 0,
    );
    await addAll(asteroidFactory.makeAsteroids(level));
    await add(Powerups());

    camera.followComponent(player);
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