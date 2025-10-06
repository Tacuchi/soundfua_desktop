import 'dart:io';
import 'package:flutter/material.dart';
import 'package:system_tray/system_tray.dart';
import 'package:path/path.dart' as path;

class SystemTrayService {
  static final SystemTrayService _instance = SystemTrayService._internal();
  factory SystemTrayService() => _instance;
  SystemTrayService._internal();

  final SystemTray _systemTray = SystemTray();
  final Menu _menu = Menu();

  bool _initialized = false;

  Future<void> initialize({
    required Future<void> Function() onConfigurationPressed,
    required void Function() onExitPressed,
  }) async {
    if (_initialized) return;

    await _initSystemTray();
    await _setupMenu(
      onConfigurationPressed: onConfigurationPressed,
      onExitPressed: onExitPressed,
    );

    _initialized = true;
  }

  Future<void> _initSystemTray() async {
    String iconPath = await _getIconPath();
    print('DEBUG: SystemTrayService - Icon path: $iconPath');

    await _systemTray.initSystemTray(
      title: 'SoundFua',
      iconPath: iconPath,
      toolTip: 'SoundFua Overlay Desktop',
    );
    print('DEBUG: SystemTrayService - System tray initialized');

    _systemTray.registerSystemTrayEventHandler((eventName) {
      print('DEBUG: SystemTrayService - Tray event received: $eventName');
      if (eventName == kSystemTrayEventClick) {
        print('DEBUG: SystemTrayService - Left click detected, showing menu');
        _systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        print('DEBUG: SystemTrayService - Right click detected, showing menu');
        _systemTray.popUpContextMenu();
      }
    });
    print('DEBUG: SystemTrayService - Event handler registered');
  }

  Future<String> _getIconPath() async {
    final String appPath = Platform.resolvedExecutable;
    final String appDir = path.dirname(appPath);

    String iconPath;
    if (Platform.isMacOS) {
      iconPath = path.join(
        appDir,
        '../Frameworks/App.framework/Resources/flutter_assets/assets/images/app_icon.png',
      );
    } else if (Platform.isWindows) {
      iconPath = path.join(
        appDir,
        'data/flutter_assets/assets/images/app_icon.png',
      );
    } else {
      iconPath = path.join(
        appDir,
        'data/flutter_assets/assets/images/app_icon.png',
      );
    }

    return iconPath;
  }

  Future<void> _setupMenu({
    required Future<void> Function() onConfigurationPressed,
    required void Function() onExitPressed,
  }) async {
    print('DEBUG: SystemTrayService - Building menu...');
    await _menu.buildFrom([
      MenuItemLabel(
        label: 'Configuración',
        onClicked: (menuItem) async {
          print('DEBUG: SystemTrayService - Menu item "Configuración" clicked');
          await onConfigurationPressed();
          print('DEBUG: SystemTrayService - onConfigurationPressed callback completed');
        },
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Salir',
        onClicked: (menuItem) {
          print('DEBUG: SystemTrayService - Menu item "Salir" clicked');
          onExitPressed();
        },
      ),
    ]);

    await _systemTray.setContextMenu(_menu);
    print('DEBUG: SystemTrayService - Menu built and set successfully');
  }

  Future<void> dispose() async {
    await _systemTray.destroy();
    _initialized = false;
  }
}
