import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:soundfua_desktop/core/services/system_tray_service.dart';
import 'package:soundfua_desktop/core/services/overlay_hotkey_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  await hotKeyManager.unregisterAll(); // Clean up any previous hotkeys

  const windowOptions = WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: 'SoundFua Overlay Desktop',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    print('DEBUG: Window ready to show');
    await windowManager.show();
    print('DEBUG: Window shown');
    // Start hidden (transparent and non-interactive)
    await windowManager.setOpacity(0.0);
    await windowManager.setIgnoreMouseEvents(true);
    print('DEBUG: Window started hidden (opacity=0.0, mouse events disabled)');
    await windowManager.setPreventClose(true);
    print('DEBUG: setPreventClose(true) called');
    final preventClose = await windowManager.isPreventClose();
    print('DEBUG: isPreventClose() = $preventClose');
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
    // Initialize hotkey service
    await _overlayHotkeyService.initialize();

    // Initialize system tray
    print('DEBUG: Initializing system tray...');
    await _systemTrayService.initialize(
      onConfigurationPressed: () async {
        print('DEBUG: === Configuration pressed callback START ===');
        try {
          await _overlayHotkeyService.showOverlay();
          print('DEBUG: === Configuration pressed callback END ===');
        } catch (e) {
          print('DEBUG: ERROR in configuration callback: $e');
        }
      },
      onExitPressed: () async {
        print('DEBUG: Exit pressed - cleaning up...');
        await _overlayHotkeyService.dispose();
        exit(0);
      },
    );
    print('DEBUG: Services initialized');
  }

  @override
  void onWindowClose() async {
    print('DEBUG: === onWindowClose called ===');
    await _overlayHotkeyService.hideOverlay();
    print('DEBUG: Overlay hidden via opacity');
  }

  @override
  void onWindowEvent(String eventName) {
    print('DEBUG: Window event: $eventName');
  }

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SoundFua Overlay Desktop'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings_system_daydream,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Hito 2: System Tray POC',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'System Tray integrado ✓',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Mira el icono en la bandeja del sistema',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 32),
            const Card(
              margin: EdgeInsets.symmetric(horizontal: 48),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🎯 Prueba estas funciones:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('✓ Cmd+Shift+Space → Toggle visibilidad overlay'),
                    SizedBox(height: 8),
                    Text('✓ Click izq/der en icono → Menú contextual'),
                    SizedBox(height: 8),
                    Text('✓ Menú > "Configuración" → Muestra overlay'),
                    SizedBox(height: 8),
                    Text('✓ Cerrar ventana (X) → Oculta overlay (mantiene posición)'),
                    SizedBox(height: 8),
                    Text('✓ Menú > "Salir" → Cierra la app'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
