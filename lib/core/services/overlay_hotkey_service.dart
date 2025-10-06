import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

class OverlayHotkeyService {
  HotKey? _toggleHotkey;
  bool _isVisible = false;

  Future<void> initialize() async {
    await hotKeyManager.unregisterAll();

    _toggleHotkey = HotKey(
      key: PhysicalKeyboardKey.space,
      modifiers: [HotKeyModifier.meta, HotKeyModifier.shift],
      scope: HotKeyScope.system,
    );

    await hotKeyManager.register(
      _toggleHotkey!,
      keyDownHandler: (hotKey) async {
        await toggleOverlayVisibility();
      },
    );
  }

  Future<void> toggleOverlayVisibility() async {
    _isVisible = !_isVisible;

    if (_isVisible) {
      await windowManager.setOpacity(1.0);
      await windowManager.setIgnoreMouseEvents(false);
      await windowManager.focus();
    } else {
      await windowManager.setOpacity(0.0);
      await windowManager.setIgnoreMouseEvents(true);
    }
  }

  Future<void> showOverlay() async {
    if (!_isVisible) {
      _isVisible = true;
      await windowManager.setOpacity(1.0);
      await windowManager.setIgnoreMouseEvents(false);
      await windowManager.focus();
    }
  }

  Future<void> hideOverlay() async {
    if (_isVisible) {
      _isVisible = false;
      await windowManager.setOpacity(0.0);
      await windowManager.setIgnoreMouseEvents(true);
    }
  }

  Future<void> dispose() async {
    await hotKeyManager.unregisterAll();
  }

  bool get isVisible => _isVisible;
}
