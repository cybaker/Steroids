import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:steroids/src/game/extensions/component_effects.dart';

import '../player/player.dart';
import 'enemy.dart';

class Pirate extends Enemy {
  Pirate({required this.player}) : super(player: player);

  final Player player;

  bool _escaping = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('skull.png');
  }

  @override
  void setupEnemyVariables() {
    shipPower = gameRef.level.piratePower;
    speed = gameRef.level.pirateSpeed;
    moveTimeoutSetting = gameRef.level.piratePathChangeIntervalSec;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      _escapeFromScreen();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void move(double dt) {
    if (_escaping) {
      position = position + moveVector * dt;
      _removeWhenEscaped();
    } else {
      super.move(dt);
    }
  }

  void _removeWhenEscaped() {
    if (_escaping) {
      if (position.x.abs() > gameRef.level.playfieldDimension ||
          position.y.abs() > gameRef.level.playfieldDimension) {
        gameRef.remove(this);
      }
    }
  }

  _escapeFromScreen() {
    if(!_escaping) {
      debugPrint('Pirate is escaping');
      _escaping = true;
      moveVector = Vector2(this.randomFromTo(-speed, speed), this.randomFromTo(-speed, speed)) * 8;
    }
  }
}
