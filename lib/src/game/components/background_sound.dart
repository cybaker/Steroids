import 'package:flame/components.dart';

import '../model/sounds.dart';
import '../steroids.dart';

class BackgroundSound extends Component with HasGameRef<Steroids> {
  BackgroundSound({required this.level}) : super();

  final int level;

  @override
  void update(double dt) {
    super.update(dt);
    Sounds.backgroundBeat();
  }
}
