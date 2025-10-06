import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:soundfua_desktop/core/services/system_tray_service.dart';
import 'package:soundfua_desktop/core/services/overlay_hotkey_service.dart';
import 'package:soundfua_desktop/features/overlay/presentation/providers/sound_providers.dart';
import 'package:soundfua_desktop/features/settings/presentation/pages/settings_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  if (args.isNotEmpty && args.first == 'multi_window') {
    runApp(
      const ProviderScope(
        child: SettingsWindowApp(),
      ),
    );
    return;
  }

  await windowManager.ensureInitialized();
  await hotKeyManager.unregisterAll();

  const windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: 'SoundFua Overlay Desktop',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.setOpacity(0.0);
    await windowManager.setIgnoreMouseEvents(true);
    await windowManager.setPreventClose(true);
  });

  runApp(
    const ProviderScope(
      child: SoundfuaApp(),
    ),
  );
}

class SoundfuaApp extends StatefulWidget {
  const SoundfuaApp({super.key});

  @override
  State<SoundfuaApp> createState() => _SoundfuaAppState();
}

class _SoundfuaAppState extends State<SoundfuaApp> with WindowListener {
  final SystemTrayService _systemTrayService = SystemTrayService();
  final OverlayHotkeyService _overlayHotkeyService = OverlayHotkeyService();
  int? _settingsWindowId;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _initServices();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    _overlayHotkeyService.dispose();
    super.dispose();
  }

  Future<void> _initServices() async {
    await _overlayHotkeyService.initialize();
    await _systemTrayService.initialize(
      onConfigurationPressed: _openSettingsWindow,
      onExitPressed: () async {
        await _overlayHotkeyService.dispose();
        exit(0);
      },
    );
  }

  Future<void> _openSettingsWindow() async {
    if (_settingsWindowId != null) {
      final allWindowIds = await DesktopMultiWindow.getAllSubWindowIds();
      
      if (allWindowIds.contains(_settingsWindowId)) {
        try {
          await WindowController.fromWindowId(_settingsWindowId!).show();
        } catch (_) {}
        return;
      } else {
        _settingsWindowId = null;
      }
    }
    
    try {
      final window = await DesktopMultiWindow.createWindow(
        jsonEncode({'type': 'settings'}),
      );
      
      _settingsWindowId = window.windowId;
      
      await window.setFrame(const Offset(100, 100) & const Size(900, 700));
      await window.center();
      await window.setTitle('SoundFua - Configuración');
      await Future.delayed(const Duration(milliseconds: 300));
      await window.show();
    } catch (_) {
      _settingsWindowId = null;
    }
  }

  @override
  void onWindowClose() async {
    await windowManager.hide();
  }

  @override
  void onWindowEvent(String eventName) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundFua Overlay',
      debugShowCheckedModeBanner: false,
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
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class SettingsWindowApp extends StatelessWidget {
  const SettingsWindowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundFua - Configuración',
      debugShowCheckedModeBanner: false,
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
      themeMode: ThemeMode.system,
      home: const SettingsPage(isStandaloneWindow: true),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundsCountAsync = ref.watch(soundsCountProvider);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.library_music,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Overlay de Sonidos',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  soundsCountAsync.when(
                    data: (count) => Text(
                      '$count sonidos disponibles',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Text('Error al cargar'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Cmd+Shift+Space para mostrar/ocultar',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
