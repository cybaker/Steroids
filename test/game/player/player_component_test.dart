import 'package:bloc_test/bloc_test.dart';
import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_adventures/game/game.dart';

import '../../helpers/helpers.dart';

class MockRawKeyDownEvent extends Mock implements RawKeyDownEvent {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class MockRawKeyUpEvent extends Mock implements RawKeyUpEvent {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class MockInventoryBloc extends Mock implements InventoryBloc {}

class MockPlayerBloc extends Mock implements PlayerBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final tester = FlameTester(VeryGoodAdventuresGame.new);

  group('PlayerGear', () {
    tester
      ..test('loads sword correctly', (game) async {
        final gear = PlayerGear(item: GameItem.sword, slot: GearSlot.leftHand);
        await game.ensureAdd(gear);

        expect(gear.sprite, isNotNull);
      })
      ..test('loads shield correctly', (game) async {
        final gear = PlayerGear(item: GameItem.shield, slot: GearSlot.leftHand);
        await game.ensureAdd(gear);

        expect(gear.sprite, isNotNull);
      })
      ..test('loads unicornHoddie correctly', (game) async {
        final gear =
            PlayerGear(item: GameItem.unicornHoddie, slot: GearSlot.head);
        await game.ensureAdd(gear);

        expect(gear.sprite, isNotNull);
      })
      ..test('loads birdHoddie correctly', (game) async {
        final gear = PlayerGear(item: GameItem.birdHoddie, slot: GearSlot.head);
        await game.ensureAdd(gear);

        expect(gear.sprite, isNotNull);
      });
  });

  group('Player', () {
    tester.test('loads correctly', (game) async {
      final player = Player();
      await game.ensureAdd(player);

      expect(player.size, equals(Vector2(30, 60)));
      expect(player.anchor, equals(Anchor.center));
      expect(player.animations?.length, equals(2));
    });

    group('update', () {
      tester
        ..test(
          'calculates the correct position when moving vertically',
          (game) async {
            final player = Player()..direction = Vector2(0, 1);

            await game.ensureAdd(player);

            game.update(0.1);

            expect(player.position.y, equals(10));
          },
        )
        ..test(
          'calculates the correct position when moving horizontally',
          (game) async {
            final player = Player()..direction = Vector2(1, 0);

            await game.ensureAdd(player);

            game.update(0.1);
            expect(player.position.x, equals(10));
          },
        )
        ..test(
          'calculates the correct position when moving on both axis',
          (game) async {
            final player = Player()..direction = Vector2(1, 1);

            await game.ensureAdd(player);
            game.update(0.1);

            expect(player.position, equals(Vector2.all(10)));
          },
        );
    });

    group('onNewState', () {
      bool Function(Component) findPlayerGear(GameItem item) =>
          (Component child) => child is PlayerGear && child.item == item;

      tester.test('adds the new gear', (game) async {
        final player = Player()
          ..onNewState(
            const PlayerState(
              gear: {
                GearSlot.head: GameItem.birdHoddie,
                GearSlot.rightHand: GameItem.sword,
                GearSlot.leftHand: GameItem.shield,
              },
            ),
          );

        await game.ensureAdd(player);

        expect(player.children.length, equals(3));
        expect(
          player.children.where(findPlayerGear(GameItem.birdHoddie)).length,
          equals(1),
        );
        expect(
          player.children.where(findPlayerGear(GameItem.sword)).length,
          equals(1),
        );
        expect(
          player.children.where(findPlayerGear(GameItem.shield)).length,
          equals(1),
        );
      });

      test('removes gear', () {
        final player = Player()
          ..onNewState(
            const PlayerState(
              gear: {
                GearSlot.head: GameItem.unicornHoddie,
                GearSlot.rightHand: GameItem.sword,
                GearSlot.leftHand: GameItem.shield,
              },
            ),
          )
          ..updateTree(0)
          ..onNewState(
            const PlayerState(
              gear: {
                GearSlot.rightHand: GameItem.sword,
              },
            ),
          )
          ..updateTree(0);

        expect(player.children.length, equals(1));
        expect(
          player.children.where(findPlayerGear(GameItem.sword)).length,
          equals(1),
        );
      });
    });

    group('onKeyEvent', () {
      setUpAll(() {
        registerFallbackValue(const GameItemPickedUp(GameItem.sword));
      });

      group('movement', () {
        tester
          ..test('goes left when A pressed', (game) {
            final event = MockRawKeyDownEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyA);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(-1, 0)));
          })
          ..test('stops moving when A is released', (game) {
            game.player.direction = Vector2(-1, 0);

            final event = MockRawKeyUpEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyA);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(0, 0)));
          })
          ..test('goes right when D pressed', (game) {
            final event = MockRawKeyDownEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyD);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(1, 0)));
          })
          ..test('stops moving when D is released', (game) {
            game.player.direction = Vector2(1, 0);

            final event = MockRawKeyUpEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyD);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(0, 0)));
          })
          ..test('goes down when S pressed', (game) {
            final event = MockRawKeyDownEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyS);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(0, 1)));
          })
          ..test('stops moving when S is released', (game) {
            game.player.direction = Vector2(0, 1);

            final event = MockRawKeyUpEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyS);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(0, 0)));
          })
          ..test('goes up when W pressed', (game) {
            final event = MockRawKeyDownEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyW);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(0, -1)));
          })
          ..test('stops moving when W is released', (game) {
            game.player.direction = Vector2(0, -1);

            final event = MockRawKeyUpEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyW);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.direction, equals(Vector2(0, 0)));
          })
          ..test('flip the sprite when going right', (game) {
            final event = MockRawKeyDownEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyA);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});

            expect(game.player.scale.x, equals(-1));
          })
          ..test('flip the sprite when going right', (game) {
            final event = MockRawKeyDownEvent();
            when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.keyA);

            game.player.onKeyEvent(event, <LogicalKeyboardKey>{});
            expect(game.player.scale.x, equals(-1));

            final secondEvent = MockRawKeyDownEvent();
            when(() => secondEvent.logicalKey).thenReturn(
              LogicalKeyboardKey.keyD,
            );

            game.player.onKeyEvent(secondEvent, <LogicalKeyboardKey>{});

            expect(game.player.scale.x, equals(1));
          });
      });

      group('item pickups', () {
        TestWidgetsFlutterBinding.ensureInitialized();

        late InventoryBloc inventoryBloc;
        late PlayerBloc playerBloc;

        setUp(() {
          inventoryBloc = MockInventoryBloc();
          whenListen(
            inventoryBloc,
            Stream.value(const InventoryState.initial()),
          );

          playerBloc = MockPlayerBloc();
          whenListen(
            playerBloc,
            Stream.value(const PlayerState.initial()),
            initialState: const PlayerState.initial(),
          );
        });

        FlameTester(
          VeryGoodAdventuresGame.new,
          pumpWidget: (gameWidget, tester) async {
            await tester.pumpWidget(
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: inventoryBloc),
                  BlocProvider.value(value: playerBloc),
                ],
                child: gameWidget,
              ),
            );
          },
        )
          ..widgetTest(
            'pick up the item when it is close enough',
            (game, tester) async {
              await tester.pump();

              await game.ensureAdd(
                Chest(item: GameItem.sword)
                  ..position = Vector2(
                    0,
                    40,
                  ),
              );

              await game.gameLoading();
              await tester.pump();

              final event = MockRawKeyUpEvent();
              when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.space);

              game.player.onKeyEvent(event, {});

              verify(
                () => inventoryBloc.add(
                  const GameItemPickedUp(GameItem.sword),
                ),
              ).called(1);
            },
          )
          ..widgetTest(
            'do nothing if no item is near',
            (game, tester) async {
              await game.ensureAdd(
                Chest(item: GameItem.sword)
                  ..position = Vector2.all(
                    100,
                  ),
              );

              await tester.pump();
              await game.gameLoading();

              final event = MockRawKeyUpEvent();
              when(() => event.logicalKey).thenReturn(LogicalKeyboardKey.space);

              game.player.onKeyEvent(event, {});

              verifyNever(
                () => inventoryBloc.add(any()),
              );
            },
          );
      });
    });
  });
}
