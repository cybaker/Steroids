import 'package:Roids/game/model/Sounds.dart';
import 'package:Roids/game/roids.dart';
import 'package:flame/components.dart';

class BackgroundSound extends Component with HasGameRef<Roids> {
  BackgroundSound({required this.level}) : super();

  final int level;

  @override
  void update(double dt) {
    super.update(dt);
    Sounds.backgroundBeat();
  }
}
