import 'package:flame/components.dart';
import 'package:flame/effects.dart';

enum GearSlot {
  head,
  leftHand,
  rightHand,
}

enum GameItem {
  sword,
  shield,
  unicornHoddie,
  birdHoddie,
}

extension GameItemX on GameItem {
  List<GearSlot> get slots {
    switch (this) {
      case GameItem.sword:
      case GameItem.shield:
        return const [GearSlot.leftHand, GearSlot.rightHand];
      case GameItem.unicornHoddie:
      case GameItem.birdHoddie:
        return const [GearSlot.head];
    }
  }
}
