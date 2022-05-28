A casual game in Flutter intended as a web app, based on Flutter's Casual Game toolkit and Flame.

Steroids

![Status](https://github.com/cybaker/Steroids/actions/workflows/publish.yaml/badge.svg)

# Getting started

This link launches a web app in your browser.

[Launch the web app](https://cybaker.github.io/Steroids/)

Tap play, select a level, and fly your ship to collect minerals from asteroids.
Use the arrow keys for movement:
- turn left (arrow up).
- turn right (arrow up).
- thrust (arrow up).
- Use the space bar to fire a dumb torpedo.
- Collect small blue asteroids by scooping them up.
- Blast larger asteroids into smaller ones. Avoid hitting larger asteroids as they damage your ship.
- Dock with the space station at the center to deposit your booty and get more ship power.
- Watch for powerups: power restore and fire faster.
- Don't let your ship power fall to zero. You'll lose the level.

![Screenshot](https://github.com/cybaker/Steroids/blob/main/assets/docs/screenshot.jpg)

# Development

To run the app in debug mode:

    flutter run

This assumes you have an Android emulator, iOS Simulator, or an attached physical device.

To run in a browser:

    flutter run -d chrome

## Code organization

Code is organized in a loose and shallow feature-first fashion.
In `lib/src`, you'll therefore find directories such as `ads`, `audio`
or `main_menu`. The main game code is built with Flame, under `game`.

```
lib
├── src
│   ├── ads
│   ├── app_lifecycle
│   ├── audio
│   ├── crashlytics
│   ├── game_internals
│   ├── games_services
│   ├── game
│   ├── in_app_purchase
│   ├── level_selection
│   ├── main_menu
│   ├── play_session
│   ├── player_progress
│   ├── settings
│   ├── style
│   └── win_game
├── ...
└── main.dart
```

The state management approach is intentionally low-level. That way, it's easy to
take this project and run with it, without having to learn new paradigms, or having
to remember to run `flutter pub run build_runner watch`.

## Building for production

Once a PR is merged to main, the web app will automatically build and deploy to the app link above.
This repo uses the Git actions by [bluefireteam](https://github.com/bluefireteam/flutter-gh-pages)

# Integrations

See [Flutter's Casual Game toolkit](https://docs.flutter.dev/resources/games-toolkit). 