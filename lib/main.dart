import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'features/sound_library/presentation/pages/home_page.dart';
import 'features/settings/presentation/providers/settings_database_providers.dart';
import 'features/settings/domain/entities/theme_mode_setting.dart';
import 'features/quick_sounds/presentation/widgets/quick_sound_overlay_manager.dart';
import 'features/quick_sounds/presentation/widgets/permissions_checker.dart';
import 'core/services/system_tray_service.dart';
import 'core/widgets/window_lifecycle_manager.dart';

import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize window manager
  await windowManager.ensureInitialized();

  // Configure window options for tray functionality
  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setPreventClose(true); // Prevent default close behavior
  });

  // Initialize hotkey manager
  await hotKeyManager.unregisterAll();

  // Initialize system tray
  await SystemTrayService().initialize();

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize settings database
    ref.watch(settingsInitializerProvider);

    final currentThemeMode = ref.watch(currentThemeModeProvider);

    return MaterialApp(
      title: 'Gestor de Biblioteca de Sonidos',
      themeMode: currentThemeMode.toThemeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const MainAppWrapper(),
    );
  }
}

/// Main app wrapper that includes the quick sound overlay
class MainAppWrapper extends ConsumerWidget {
  const MainAppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WindowLifecycleManager(
      child: PermissionsChecker(
        child: Stack(
          children: [
            const HomePage(),
            // Quick sound overlay manager
            const QuickSoundOverlayManager(),
          ],
        ),
      ),
    );
  }
}
