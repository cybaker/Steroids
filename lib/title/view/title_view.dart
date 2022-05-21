import 'package:Roids/game/view/game_page.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  const TitleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: const Hero(
                tag: 'logo',
                child: Text('Roids', style: TextStyle(color: Colors.amber, fontSize: 64),),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(GamePage.route(),);
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Play!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
