# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Soundfua Desktop is a Flutter desktop application for managing and playing sound libraries with quick access hotkeys. It supports macOS, Windows, and Linux platforms, with system tray integration, global hotkeys, and audio device selection.

## Architecture

### Clean Architecture Pattern

The codebase follows Clean Architecture with clear separation between layers:

- **Domain Layer** (`lib/features/*/domain/`): Contains business logic, entities, use cases, repositories (interfaces), and services (interfaces). Uses immutable entities with Freezed.
- **Data Layer** (`lib/features/*/data/`): Implements repositories, contains data sources (local, file, database), and models. Models convert between entities and data layer.
- **Presentation Layer** (`lib/features/*/presentation/`): Contains UI (pages, widgets), state management (Riverpod providers), and state classes.

### Dependency Injection

All DI is centralized in `lib/core/di/injection.dart` using Riverpod providers. The file follows a clear pattern:
1. Data source providers
2. Repository providers
3. Use case providers
4. Service providers

Services are typically singletons, initialized in `main.dart` before app startup.

### Feature Structure

Three main features, each following Clean Architecture:

1. **sound_library**: Core sound management (CRUD operations, file storage, playback with device selection)
2. **settings**: App configuration (theme, keyboard shortcuts, volume, audio device selection)
3. **quick_sounds**: Global hotkey overlay for quick sound playback

### Core Components

- **Database** (`lib/features/sound_library/data/datasources/local/app_database.dart`): Drift-based SQLite database with two tables: `sounds` and `settings`
- **Error Handling**: Uses `Either<Failure, T>` pattern from dartz. All failures are defined in `lib/core/error/failures.dart` using Freezed
- **Use Cases**: All inherit from `UseCase<ReturnType, Params>` base class in `lib/core/usecases/usecase.dart`
- **Audio**: Uses `dart_vlc` for playback with device selection via `AudioDeviceService` and `MultiAudioService`
- **System Integration**:
  - `SystemTrayService` for tray functionality
  - `hotkey_manager` for global shortcuts
  - `window_manager` for window lifecycle

### State Management

Uses Riverpod throughout. State classes use Freezed for immutability. Providers are organized in feature-specific provider files (`*_providers.dart`).

## Development Commands

### Code Generation

Run after changing Freezed/JSON/Drift models:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch mode for continuous generation:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Running the App

```bash
flutter run -d macos    # macOS
flutter run -d windows  # Windows
flutter run -d linux    # Linux
```

### Building

```bash
flutter build macos
flutter build windows
flutter build linux
```

### Testing

```bash
flutter test
```

Run specific test:
```bash
flutter test test/widget_test.dart
```

### Linting

```bash
flutter analyze
```

### Dependencies

Get dependencies:
```bash
flutter pub get
```

Update dependencies:
```bash
flutter pub upgrade
```

## Key Technical Details

### Generated Files

Never manually edit these files (regenerate with build_runner):
- `*.g.dart` - JSON serialization and Drift queries
- `*.freezed.dart` - Freezed immutable classes

### Database Migrations

When changing database schema:
1. Update table definitions in `app_database.dart`
2. Increment `schemaVersion`
3. Add migration logic in `onUpgrade` callback if needed
4. Run build_runner to regenerate

### Audio Device Selection

The app maintains a selected audio device via `AudioDeviceService` (initialized in `main.dart` with SharedPreferences). All playback services (`MultiAudioService`, individual audio players) respect the selected device. Device selection persists across app restarts.

### Global Hotkeys

Hotkeys are managed by `QuickSoundService`:
- Registration happens when user configures shortcuts in settings
- Hotkeys trigger overlay with sound list
- Overlay uses arrow keys for navigation, Enter/Space to play
- All hotkeys are unregistered on app close

### Window Lifecycle

The app uses `WindowLifecycleManager` to prevent accidental window closure:
- Window close button minimizes to tray instead of quitting
- Use tray menu "Quit" option to actually exit
- This is configured in `main.dart` with `setPreventClose(true)`

## Common Development Patterns

### Adding a New Use Case

1. Create entity in `domain/entities/`
2. Define repository interface in `domain/repositories/`
3. Create use case in `domain/usecases/` extending `UseCase<ReturnType, Params>`
4. Implement repository in `data/repositories/`
5. Create data source in `data/datasources/`
6. Register all in `core/di/injection.dart`
7. Use in presentation via Riverpod provider

### Adding a New Setting

1. Add entity in `features/settings/domain/entities/`
2. Create model in `features/settings/data/models/`
3. Add getter/setter methods to `SettingsDatabaseDataSource`
4. Create get/save use cases
5. Register use cases in DI
6. Create provider in presentation layer
7. Add UI widget in `features/settings/presentation/widgets/`

### Working with Audio

- Use `MultiAudioService` for multiple simultaneous sounds
- Single sounds can use individual players from `audio_providers.dart`
- Always check current device via `AudioDeviceService.getCurrentDevice()`
- Set device on players before playback with `player.setAudioDevice()`
