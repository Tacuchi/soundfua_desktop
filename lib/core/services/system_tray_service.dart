import 'dart:io';
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

    await _systemTray.initSystemTray(
      title: 'SoundFua',
      iconPath: iconPath,
      toolTip: 'SoundFua Overlay Desktop',
    );

    _systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == kSystemTrayEventClick ||
          eventName == kSystemTrayEventRightClick) {
        _systemTray.popUpContextMenu();
      }
    });
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
    await _menu.buildFrom([
      MenuItemLabel(
        label: 'Configuración',
        onClicked: (menuItem) async => await onConfigurationPressed(),
      ),
      MenuSeparator(),
      MenuItemLabel(
        label: 'Salir',
        onClicked: (menuItem) => onExitPressed(),
      ),
    ]);

    await _systemTray.setContextMenu(_menu);
  }

  Future<void> dispose() async {
    await _systemTray.destroy();
    _initialized = false;
  }
}
