import 'package:flame/components.dart';

import '../util/sounds.dart';
import '../steroids.dart';

class BackgroundSound extends Component with HasGameRef<SteroidsLevel> {
  BackgroundSound() : super();

  @override
  void update(double dt) {
    super.update(dt);
    Sounds.backgroundBeat();
  }
}
