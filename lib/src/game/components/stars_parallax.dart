import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class StarsParallax extends ParallaxComponent {
  StarsParallax()
      : super(
          priority: 0,
        );

  Vector2 lastCameraPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('stars1.png'),
        ParallaxImageData('stars2.png'),
      ],
      velocityMultiplierDelta: Vector2(0.5, 0.5),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    final cameraPosition = gameRef.camera.position;
    final delta = dt > 0.005 ? 1.0 / (dt * 60) : 1.0;
    final baseVelocity = cameraPosition
      ..sub(lastCameraPosition)
      ..multiply(Vector2(10, 10))
      ..multiply(Vector2(delta, delta));
    parallax!.baseVelocity.setFrom(baseVelocity);
    lastCameraPosition.setFrom(gameRef.camera.position);
  }
}
