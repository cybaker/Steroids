import 'package:flutter/material.dart';

import 'game_view.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return const GamePage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const GameView();
  }
}
