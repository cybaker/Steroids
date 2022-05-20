import 'package:Roids/game/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() =>
      GameViewState();
}

class GameViewState
    extends State<GameView> {
  late FocusNode gameFocusNode;

  @override
  void initState() {
    super.initState();

    gameFocusNode = FocusNode();
  }

  @override
  void dispose() {
    gameFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: MouseRegion(
              onHover: (_) {
                if (!gameFocusNode.hasFocus) {
                  gameFocusNode.requestFocus();
                }
              },
              child: GameWidget(
                focusNode: gameFocusNode,
                game: Roids(),
              ),
            ),
          ),
          SizedBox(
            width: 250,
            height: double.infinity,
            child: Column(
              children: [
                PlayerViewPanel(shipStrength: Roids.singlePlayer.shipStrength, shipStorage: Roids.singlePlayer.shipStorage),
                Expanded(child: StationViewPanel(
                  stationStorage: Roids.singleStation.stationStorage,)),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
