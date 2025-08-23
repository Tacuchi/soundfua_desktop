import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

part 'keyboard_shortcut_setting.freezed.dart';
part 'keyboard_shortcut_setting.g.dart';

/// Default keyboard shortcuts
enum DefaultShortcuts {
  quickSounds('CMD+0');

  const DefaultShortcuts(this.shortcut);
  final String shortcut;
}

/// Keyboard shortcut setting entity
@freezed
class KeyboardShortcutSetting with _$KeyboardShortcutSetting {
  const factory KeyboardShortcutSetting({
    @Default('CMD+0') String quickSoundsShortcut,
  }) = _KeyboardShortcutSetting;

  factory KeyboardShortcutSetting.fromJson(Map<String, dynamic> json) =>
      _$KeyboardShortcutSettingFromJson(json);
}

/// Extension to convert shortcut string to HotKey
extension KeyboardShortcutExtension on KeyboardShortcutSetting {
  /// Parse the quick sounds shortcut into a HotKey
  HotKey get quickSoundsHotKey {
    return _parseShortcut(quickSoundsShortcut);
  }

  /// Parse a shortcut string into HotKey
  HotKey _parseShortcut(String shortcut) {
    final parts = shortcut.toUpperCase().split('+');

    // Extract modifiers and key
    final modifiers = <HotKeyModifier>[];
    String? keyCode;

    for (final part in parts) {
      switch (part.trim()) {
        case 'CMD':
        case 'COMMAND':
          modifiers.add(HotKeyModifier.meta);
          break;
        case 'CTRL':
        case 'CONTROL':
          modifiers.add(HotKeyModifier.control);
          break;
        case 'ALT':
        case 'OPTION':
          modifiers.add(HotKeyModifier.alt);
          break;
        case 'SHIFT':
          modifiers.add(HotKeyModifier.shift);
          break;
        default:
          // This should be the key
          keyCode = part.trim();
      }
    }

    // Map common keys
    final mappedKey = _mapKeyCode(keyCode ?? '0');

    return HotKey(key: mappedKey, modifiers: modifiers);
  }

  /// Map string key code to LogicalKeyboardKey
  LogicalKeyboardKey _mapKeyCode(String keyCode) {
    switch (keyCode.toUpperCase()) {
      case '0':
        return LogicalKeyboardKey.digit0;
      case '1':
        return LogicalKeyboardKey.digit1;
      case '2':
        return LogicalKeyboardKey.digit2;
      case '3':
        return LogicalKeyboardKey.digit3;
      case '4':
        return LogicalKeyboardKey.digit4;
      case '5':
        return LogicalKeyboardKey.digit5;
      case '6':
        return LogicalKeyboardKey.digit6;
      case '7':
        return LogicalKeyboardKey.digit7;
      case '8':
        return LogicalKeyboardKey.digit8;
      case '9':
        return LogicalKeyboardKey.digit9;
      case 'A':
        return LogicalKeyboardKey.keyA;
      case 'B':
        return LogicalKeyboardKey.keyB;
      case 'C':
        return LogicalKeyboardKey.keyC;
      case 'D':
        return LogicalKeyboardKey.keyD;
      case 'E':
        return LogicalKeyboardKey.keyE;
      case 'F':
        return LogicalKeyboardKey.keyF;
      case 'G':
        return LogicalKeyboardKey.keyG;
      case 'H':
        return LogicalKeyboardKey.keyH;
      case 'I':
        return LogicalKeyboardKey.keyI;
      case 'J':
        return LogicalKeyboardKey.keyJ;
      case 'K':
        return LogicalKeyboardKey.keyK;
      case 'L':
        return LogicalKeyboardKey.keyL;
      case 'M':
        return LogicalKeyboardKey.keyM;
      case 'N':
        return LogicalKeyboardKey.keyN;
      case 'O':
        return LogicalKeyboardKey.keyO;
      case 'P':
        return LogicalKeyboardKey.keyP;
      case 'Q':
        return LogicalKeyboardKey.keyQ;
      case 'R':
        return LogicalKeyboardKey.keyR;
      case 'S':
        return LogicalKeyboardKey.keyS;
      case 'T':
        return LogicalKeyboardKey.keyT;
      case 'U':
        return LogicalKeyboardKey.keyU;
      case 'V':
        return LogicalKeyboardKey.keyV;
      case 'W':
        return LogicalKeyboardKey.keyW;
      case 'X':
        return LogicalKeyboardKey.keyX;
      case 'Y':
        return LogicalKeyboardKey.keyY;
      case 'Z':
        return LogicalKeyboardKey.keyZ;
      case 'SPACE':
        return LogicalKeyboardKey.space;
      case 'ENTER':
        return LogicalKeyboardKey.enter;
      case 'ESC':
      case 'ESCAPE':
        return LogicalKeyboardKey.escape;
      default:
        // Default to digit 0 if unrecognized
        return LogicalKeyboardKey.digit0;
    }
  }

  /// Get display name for the shortcut
  String get quickSoundsDisplayName {
    return quickSoundsShortcut
        .replaceAll('CMD', '⌘')
        .replaceAll('CTRL', '^')
        .replaceAll('ALT', '⌥')
        .replaceAll('SHIFT', '⇧');
  }
}
