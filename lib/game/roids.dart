import 'dart:async';

import 'package:Roids/game/components/game_edge.dart';
import 'package:Roids/game/components/powerup_spawn.dart';
import 'package:Roids/game/components/stars_parallax.dart';
import 'package:Roids/game/game.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final Map<LogicalKeyboardKey, LogicalKeyboardKey> playersKeys =
  {
    LogicalKeyboardKey.arrowUp: LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown: LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft: LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight: LogicalKeyboardKey.arrowRight,
  };

// TODO Github
// TODO Player and Station game_view looks
// TODO GameBalance holding most game parameters, like #asteroids, #levels, maxShipEnergy, etc.
// TODO upgrades like faster rotation, faster shots, shorter shot recharging, etc
// TODO sounds
// TODO Disruptor powerup - like flechette, shatters all roids down to smallest on hit
// TODO Level logic so players can play a campaign.

class Roids extends FlameGame
    with KeyboardEvents, HasCollisionDetection {
  static final Vector2 resolution = Vector2(600, 600);

  late final Player player;
  late Set<LogicalKeyboardKey> pressedKeySet;
  bool isGameOver = false;

  static final singlePlayer = Player(); // Global only one player
  static final singleStation = Station(); // Global only one player

  static const double fieldSize = 600; // half size of the playing field

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    pressedKeySet = {};

    camera.viewport = FixedResolutionViewport(
      Vector2(resolution.x, resolution.y),
    );

    final asteroidFactory = AsteroidFactory();

    await add(Stars1Parallax());

    await add(GameEdge());

    await add(player = singlePlayer..y = 40);

    await add(
      singleStation
        ..x = -80
        ..y = -40,
    );
    await addAll(asteroidFactory.makeAsteroids());
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
