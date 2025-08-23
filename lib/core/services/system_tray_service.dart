import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:system_tray/system_tray.dart';
import 'package:window_manager/window_manager.dart';
import '../util/logger.dart';

/// Service to manage system tray functionality
class SystemTrayService {
  static final SystemTrayService _instance = SystemTrayService._internal();
  factory SystemTrayService() => _instance;
  SystemTrayService._internal();

  final SystemTray _systemTray = SystemTray();
  final Menu _menu = Menu();
  bool _isInitialized = false;
  bool _isWindowHidden = false;

  /// Initialize the system tray
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      Logger().info('Initializing system tray', tag: 'SYSTEM_TRAY');

      // Initialize the window state based on current visibility
      _isWindowHidden = !(await windowManager.isVisible());
      Logger().info(
        'Initial window state: hidden=$_isWindowHidden',
        tag: 'SYSTEM_TRAY',
      );

      // Initialize system tray with app icon
      String iconPath = 'assets/images/app_icon.png';

      Logger().info(
        'Initializing system tray with icon: $iconPath',
        tag: 'SYSTEM_TRAY',
      );

      await _systemTray.initSystemTray(
        title: "Sound Library",
        iconPath: iconPath,
        toolTip: "Gestor de Biblioteca de Sonidos - Haz clic para mostrar",
      );

      // Set up context menu
      await _setupContextMenu();

      // Set up tray click handlers
      _systemTray.registerSystemTrayEventHandler((eventName) {
        Logger().info('Tray event received: $eventName', tag: 'SYSTEM_TRAY');

        switch (eventName) {
          case kSystemTrayEventClick:
            Logger().info(
              'Left click detected - ignoring to prevent app closure',
              tag: 'SYSTEM_TRAY',
            );
            // Ignore left click to prevent application closure
            break;
          case kSystemTrayEventRightClick:
            Logger().info(
              'Right click detected - showing context menu',
              tag: 'SYSTEM_TRAY',
            );
            _systemTray.popUpContextMenu();
            break;
          default:
            Logger().debug(
              'Unhandled tray event: $eventName',
              tag: 'SYSTEM_TRAY',
            );
        }
      });

      _isInitialized = true;
      Logger().info('System tray initialized successfully', tag: 'SYSTEM_TRAY');
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to initialize system tray',
        tag: 'SYSTEM_TRAY',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Set up the context menu for the system tray
  Future<void> _setupContextMenu() async {
    await _menu.buildFrom([
      MenuItemLabel(
        label: 'Mostrar/Ocultar',
        onClicked: (menuItem) {
          Logger().info(
            'Menu item clicked: Mostrar/Ocultar',
            tag: 'SYSTEM_TRAY',
          );
          _toggleWindowVisibility();
        },
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Sonidos Rápidos (ALT+S)',
        onClicked: (menuItem) {
          Logger().info(
            'Menu item clicked: Sonidos Rápidos',
            tag: 'SYSTEM_TRAY',
          );
          _triggerQuickSounds();
        },
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Ajustes',
        onClicked: (menuItem) {
          Logger().info('Menu item clicked: Ajustes', tag: 'SYSTEM_TRAY');
          _openSettings();
        },
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Acerca de',
        onClicked: (menuItem) {
          Logger().info('Menu item clicked: Acerca de', tag: 'SYSTEM_TRAY');
          _showAbout();
        },
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Salir',
        onClicked: (menuItem) {
          Logger().info('Menu item clicked: Salir', tag: 'SYSTEM_TRAY');
          _quitApplication();
        },
      ),
    ]);

    await _systemTray.setContextMenu(_menu);
  }

  /// Toggle window visibility
  Future<void> _toggleWindowVisibility() async {
    try {
      Logger().info(
        'Toggle window visibility called. Current state: hidden=$_isWindowHidden',
        tag: 'SYSTEM_TRAY',
      );

      if (_isWindowHidden) {
        await showWindow();
      } else {
        await hideWindow();
      }
    } catch (e) {
      Logger().error(
        'Failed to toggle window visibility',
        tag: 'SYSTEM_TRAY',
        error: e,
      );
    }
  }

  /// Show the application window
  Future<void> showWindow() async {
    try {
      // Restore from minimized state if needed
      if (await windowManager.isMinimized()) {
        await windowManager.restore();
      }

      // Set skip taskbar to false first, then show
      await windowManager.setSkipTaskbar(false);
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setAlwaysOnTop(true);
      // Remove always on top after a short delay to ensure focus
      Future.delayed(const Duration(milliseconds: 100), () async {
        await windowManager.setAlwaysOnTop(false);
      });

      _isWindowHidden = false;

      Logger().info('Window shown from system tray', tag: 'SYSTEM_TRAY');
    } catch (e) {
      Logger().error('Failed to show window', tag: 'SYSTEM_TRAY', error: e);
      // Don't change the state if showing failed
    }
  }

  /// Hide the application window to system tray
  Future<void> hideWindow() async {
    try {
      // On macOS, we need to be careful with hide() as it can terminate the app
      // Instead, we minimize and set skip taskbar
      await windowManager.setSkipTaskbar(true);
      await windowManager.minimize();
      _isWindowHidden = true;

      Logger().info('Window hidden to system tray', tag: 'SYSTEM_TRAY');
    } catch (e) {
      Logger().error('Failed to hide window', tag: 'SYSTEM_TRAY', error: e);
      // Don't change the state if hiding failed
    }
  }

  /// Check if window is currently hidden
  bool get isWindowHidden => _isWindowHidden;

  /// Trigger quick sounds functionality
  void _triggerQuickSounds() {
    Logger().info(
      'Quick sounds triggered from system tray',
      tag: 'SYSTEM_TRAY',
    );
    // This will be handled by the QuickSoundService
    // We can emit an event or call a callback here
  }

  /// Open settings page
  void _openSettings() {
    Logger().info('Settings opened from system tray', tag: 'SYSTEM_TRAY');
    showWindow(); // Show window and navigate to settings
    // Navigation logic will be handled by the main app
  }

  /// Show about dialog
  void _showAbout() {
    Logger().info(
      'About dialog requested from system tray',
      tag: 'SYSTEM_TRAY',
    );
    showWindow(); // Show window first
    // About dialog logic will be handled by the main app
  }

  /// Quit the application
  Future<void> _quitApplication() async {
    try {
      Logger().info(
        'Application quit requested from system tray',
        tag: 'SYSTEM_TRAY',
      );

      // Clean up system tray
      await dispose();

      // Exit the application cleanly
      SystemNavigator.pop();
    } catch (e) {
      Logger().error(
        'Failed to quit application',
        tag: 'SYSTEM_TRAY',
        error: e,
      );
      // Fallback: force exit
      exit(0);
    }
  }

  /// Update tray title
  Future<void> updateTitle(String title) async {
    if (!_isInitialized) return;

    try {
      await _systemTray.setTitle(title);
    } catch (e) {
      Logger().warning('Failed to update tray title', tag: 'SYSTEM_TRAY');
    }
  }

  /// Update tray tooltip
  Future<void> updateToolTip(String toolTip) async {
    if (!_isInitialized) return;

    try {
      await _systemTray.setToolTip(toolTip);
    } catch (e) {
      Logger().warning('Failed to update tray tooltip', tag: 'SYSTEM_TRAY');
    }
  }

  /// Show notification from system tray
  Future<void> showNotification({
    required String title,
    required String message,
    Duration? duration,
  }) async {
    try {
      // Note: system_tray package might not support notifications directly
      // This is a placeholder for future notification functionality
      Logger().info('Notification: $title - $message', tag: 'SYSTEM_TRAY');
    } catch (e) {
      Logger().warning('Failed to show notification', tag: 'SYSTEM_TRAY');
    }
  }

  /// Dispose system tray resources
  Future<void> dispose() async {
    try {
      if (_isInitialized) {
        await _systemTray.destroy();
        _isInitialized = false;
        Logger().info('System tray disposed', tag: 'SYSTEM_TRAY');
      }
    } catch (e) {
      Logger().warning('Error disposing system tray', tag: 'SYSTEM_TRAY');
    }
  }
}
