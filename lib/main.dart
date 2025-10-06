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

  // Si se reciben argumentos, es una subventana
  // desktop_multi_window envía: ['multi_window', 'windowId', 'arguments']
  if (args.isNotEmpty && args.first == 'multi_window') {
    final windowId = int.parse(args[1]);
    print('DEBUG: SubWindow started with ID: $windowId');
    
    // Importar dinámicamente el entry point de la ventana de configuración
    // Esta ventana se maneja con su propio MaterialApp
    runApp(
      const ProviderScope(
        child: SettingsWindowApp(),
      ),
    );
    return;
  }

  // Ventana principal (overlay)
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
    print('DEBUG: Main window ready to show');
    await windowManager.show();
    print('DEBUG: Main window shown');
    // Start hidden (transparent and non-interactive)
    await windowManager.setOpacity(0.0);
    await windowManager.setIgnoreMouseEvents(true);
    print('DEBUG: Main window started hidden (opacity=0.0, mouse events disabled)');
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
    // Initialize hotkey service
    await _overlayHotkeyService.initialize();

    // Initialize system tray
    print('DEBUG: Initializing system tray...');
    await _systemTrayService.initialize(
      onConfigurationPressed: _openSettingsWindow,
      onExitPressed: () async {
        print('DEBUG: Exit pressed - cleaning up...');
        await _overlayHotkeyService.dispose();
        exit(0);
      },
    );
    print('DEBUG: Services initialized');
  }

  Future<void> _openSettingsWindow() async {
    print('DEBUG: === Opening settings window as separate window ===');
    
    // Si ya existe una ventana de configuración, verificar si aún está abierta
    if (_settingsWindowId != null) {
      // Obtener lista de ventanas abiertas
      final allWindowIds = await DesktopMultiWindow.getAllSubWindowIds();
      
      if (allWindowIds.contains(_settingsWindowId)) {
        print('DEBUG: Settings window $_settingsWindowId already exists, bringing to front');
        // La ventana existe, solo mostrarla (por si estaba minimizada)
        try {
          await WindowController.fromWindowId(_settingsWindowId!).show();
        } catch (e) {
          print('DEBUG: Could not show window: $e');
        }
        return;
      } else {
        print('DEBUG: Settings window $_settingsWindowId no longer exists');
        _settingsWindowId = null;
      }
    }
    
    try {
      final window = await DesktopMultiWindow.createWindow(
        jsonEncode({
          'type': 'settings',
        }),
      );
      
      _settingsWindowId = window.windowId;
      print('DEBUG: Settings window created with ID: ${window.windowId}');
      
      // Configurar la ventana pero no mostrarla aún
      await window.setFrame(const Offset(100, 100) & const Size(900, 700));
      await window.center();
      await window.setTitle('SoundFua - Configuración');
      
      // Esperar un momento para que Flutter inicialice antes de mostrar
      await Future.delayed(const Duration(milliseconds: 300));
      
      await window.show();
      
      print('DEBUG: Settings window configured and shown');
    } catch (e) {
      print('ERROR: Failed to create settings window: $e');
      _settingsWindowId = null;
    }
  }

  @override
  void onWindowClose() async {
    print('DEBUG: === onWindowClose called - hiding to tray ===');
    await windowManager.hide();
    print('DEBUG: Window hidden to tray');
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

/// App para la ventana de configuración
class SettingsWindowApp extends StatefulWidget {
  const SettingsWindowApp({super.key});

  @override
  State<SettingsWindowApp> createState() => _SettingsWindowAppState();
}

class _SettingsWindowAppState extends State<SettingsWindowApp> {
  @override
  void initState() {
    super.initState();
    print('DEBUG: SettingsWindowApp initState called');
  }

  @override
  Widget build(BuildContext context) {
    print('DEBUG: Building SettingsWindowApp');
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
