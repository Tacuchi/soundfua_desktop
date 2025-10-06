import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';

/// Service that manages the global hotkey for toggling overlay visibility
class OverlayHotkeyService {
  HotKey? _toggleHotkey;
  bool _isVisible = false; // Start hidden

  /// Initialize the hotkey service with a default hotkey (Cmd+Shift+Space on macOS, Ctrl+Shift+Space on others)
  Future<void> initialize() async {
    await hotKeyManager.unregisterAll();

    // Default hotkey: Cmd/Ctrl + Shift + Space
    _toggleHotkey = HotKey(
      key: PhysicalKeyboardKey.space,
      modifiers: [HotKeyModifier.meta, HotKeyModifier.shift], // Cmd+Shift on macOS
      scope: HotKeyScope.system,
    );

    await hotKeyManager.register(
      _toggleHotkey!,
      keyDownHandler: (hotKey) async {
        await toggleOverlayVisibility();
      },
    );

    print('DEBUG: Hotkey registered - Cmd+Shift+Space to toggle overlay');
  }

  /// Toggle the overlay visibility using opacity and mouse event blocking
  Future<void> toggleOverlayVisibility() async {
    _isVisible = !_isVisible;

    if (_isVisible) {
      // Show overlay: make opaque and enable mouse events
      print('DEBUG: Showing overlay...');
      await windowManager.setOpacity(1.0);
      await windowManager.setIgnoreMouseEvents(false);
      await windowManager.focus();
      print('DEBUG: Overlay shown (opacity=1.0, mouse events enabled)');
    } else {
      // Hide overlay: make transparent and disable mouse events
      print('DEBUG: Hiding overlay...');
      await windowManager.setOpacity(0.0);
      await windowManager.setIgnoreMouseEvents(true);
      print('DEBUG: Overlay hidden (opacity=0.0, mouse events disabled)');
    }
  }

  /// Show the overlay (make it visible and interactive)
  Future<void> showOverlay() async {
    if (!_isVisible) {
      _isVisible = true;
      await windowManager.setOpacity(1.0);
      await windowManager.setIgnoreMouseEvents(false);
      await windowManager.focus();
      print('DEBUG: Overlay shown');
    }
  }

  /// Hide the overlay (make it transparent and non-interactive)
  Future<void> hideOverlay() async {
    if (_isVisible) {
      _isVisible = false;
      await windowManager.setOpacity(0.0);
      await windowManager.setIgnoreMouseEvents(true);
      print('DEBUG: Overlay hidden');
    }
  }

  /// Dispose and unregister all hotkeys
  Future<void> dispose() async {
    await hotKeyManager.unregisterAll();
    print('DEBUG: Hotkeys unregistered');
  }

  /// Get current visibility state
  bool get isVisible => _isVisible;
}
