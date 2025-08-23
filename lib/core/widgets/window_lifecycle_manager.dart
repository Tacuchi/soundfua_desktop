import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../services/system_tray_service.dart';
import '../util/logger.dart';

/// Widget that manages window lifecycle events
class WindowLifecycleManager extends StatefulWidget with WindowListener {
  final Widget child;

  const WindowLifecycleManager({super.key, required this.child});

  @override
  State<WindowLifecycleManager> createState() => _WindowLifecycleManagerState();
}

class _WindowLifecycleManagerState extends State<WindowLifecycleManager>
    with WindowListener {
  final SystemTrayService _systemTrayService = SystemTrayService();

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    Logger().info(
      'WindowLifecycleManager initialized',
      tag: 'WINDOW_LIFECYCLE',
    );
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    Logger().info('WindowLifecycleManager disposed', tag: 'WINDOW_LIFECYCLE');
    super.dispose();
  }

  @override
  void onWindowClose() async {
    Logger().info(
      '🔄 Window close event detected - preventing close and hiding to tray',
      tag: 'WINDOW_LIFECYCLE',
    );

    // Prevent the default close behavior and hide to system tray instead
    try {
      await windowManager.setPreventClose(true);
      await _systemTrayService.hideWindow();

      // Show a brief notification that the app is still running
      await _systemTrayService.showNotification(
        title: 'Gestor de Biblioteca de Sonidos',
        message:
            'La aplicación sigue ejecutándose en la barra de estado. Haz clic en el icono para mostrar.',
        duration: const Duration(seconds: 3),
      );

      Logger().info(
        '✅ Window hidden to tray successfully',
        tag: 'WINDOW_LIFECYCLE',
      );
    } catch (e) {
      Logger().error(
        '❌ Failed to hide window to tray: $e',
        tag: 'WINDOW_LIFECYCLE',
      );
    }
  }

  @override
  void onWindowFocus() {
    Logger().debug('Window focused', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowBlur() {
    Logger().debug('Window blurred', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowMinimize() {
    Logger().debug('Window minimized', tag: 'WINDOW_LIFECYCLE');
    // Don't hide to tray here - this would create a loop with hideWindow()
    // The minimize action is already handled by the close event or explicit hide calls
  }

  @override
  void onWindowRestore() {
    Logger().debug('Window restored', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowMaximize() {
    Logger().debug('Window maximized', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowUnmaximize() {
    Logger().debug('Window unmaximized', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowMoved() {
    Logger().debug('Window moved', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowResized() {
    Logger().debug('Window resized', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowEnterFullScreen() {
    Logger().debug('Window entered full screen', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  void onWindowLeaveFullScreen() {
    Logger().debug('Window left full screen', tag: 'WINDOW_LIFECYCLE');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
