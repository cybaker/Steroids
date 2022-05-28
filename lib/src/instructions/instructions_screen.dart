// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';
import '../style/responsive_screen.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  static const _gap = SizedBox(height: 60);

  final String instructions = '''
- Tap play, select a level, and fly your ship to collect minerals from asteroids.
- Use the arrow keys for movement:
  - turn left (arrow up).
  - turn right (arrow up).
  - thrust (arrow up).
  - Use the space bar to fire a dumb torpedo.

- Collect small blue asteroids by scooping them up.
- Blast larger asteroids into smaller ones. Avoid hitting larger asteroids as they damage your ship.
- Dock with the space station at the center to deposit your booty and get more ship power.
- Watch for powerups: power restore and fire faster.
- Watch out for Aliens and Pirates! Pirates take your booty. Aliens want to blow you out of space.
- Don't let your ship power fall to zero. You'll lose the level.
    ''';

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreen(
        squarishMainArea: ListView(
          children: [
            _gap,
            Text('Instructions', textAlign: TextAlign.center, style: palette.title,),
            _gap,
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(instructions, style: palette.subtitle,),
            ),
            _gap,
          ],
        ),
        rectangularMenuArea: ElevatedButton(
          child: const Text('Back'),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
    );
  }
}
