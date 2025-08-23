import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/util/logger.dart';

/// Widget para grabar atajos de teclado automáticamente
class HotkeyRecorderTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String currentShortcut;
  final Function(String) onShortcutChanged;
  final IconData icon;

  const HotkeyRecorderTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentShortcut,
    required this.onShortcutChanged,
    this.icon = Icons.keyboard,
  });

  @override
  State<HotkeyRecorderTile> createState() => _HotkeyRecorderTileState();
}

class _HotkeyRecorderTileState extends State<HotkeyRecorderTile> {
  bool _isRecording = false;
  Set<LogicalKeyboardKey> _pressedKeys = {};
  String _recordedShortcut = '';
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _recordedShortcut = widget.currentShortcut;
  }

  @override
  void didUpdateWidget(HotkeyRecorderTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentShortcut != widget.currentShortcut) {
      _recordedShortcut = widget.currentShortcut;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _pressedKeys.clear();
      _recordedShortcut = '';
    });

    _focusNode.requestFocus();
    Logger().debug('Started recording hotkey', tag: 'HOTKEY_RECORDER');
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });

    _focusNode.unfocus();

    if (_recordedShortcut.isNotEmpty &&
        _recordedShortcut != widget.currentShortcut) {
      Logger().info(
        'Recorded new hotkey: $_recordedShortcut',
        tag: 'HOTKEY_RECORDER',
      );
      widget.onShortcutChanged(_recordedShortcut);
    } else if (_recordedShortcut.isEmpty) {
      // Revert to current shortcut if nothing was recorded
      setState(() {
        _recordedShortcut = widget.currentShortcut;
      });
    }
  }

  void _cancelRecording() {
    setState(() {
      _isRecording = false;
      _recordedShortcut = widget.currentShortcut;
      _pressedKeys.clear();
    });

    _focusNode.unfocus();
    Logger().debug('Cancelled hotkey recording', tag: 'HOTKEY_RECORDER');
  }

  void _resetToDefault() {
    const defaultShortcut = 'CMD+0';
    setState(() {
      _recordedShortcut = defaultShortcut;
    });
    widget.onShortcutChanged(defaultShortcut);
    Logger().info(
      'Reset hotkey to default: $defaultShortcut',
      tag: 'HOTKEY_RECORDER',
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!_isRecording) return KeyEventResult.ignored;

    Logger().debug(
      'Key event: ${event.runtimeType} - ${event.logicalKey}',
      tag: 'HOTKEY_RECORDER',
    );

    if (event is KeyDownEvent) {
      _pressedKeys.add(event.logicalKey);
      _updateRecordedShortcut();
    } else if (event is KeyUpEvent) {
      // When user releases keys, finalize the recording if we have a valid combination
      if (_pressedKeys.isNotEmpty && _recordedShortcut.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && _isRecording) {
            _stopRecording();
          }
        });
      }
    }

    return KeyEventResult.handled;
  }

  void _updateRecordedShortcut() {
    final modifiers = <String>[];
    final keys = <String>[];

    for (final key in _pressedKeys) {
      final keyLabel = _getKeyLabel(key);
      if (_isModifierKey(key)) {
        if (!modifiers.contains(keyLabel)) {
          modifiers.add(keyLabel);
        }
      } else {
        if (!keys.contains(keyLabel)) {
          keys.add(keyLabel);
        }
      }
    }

    // Only create shortcut if we have at least one modifier and one key
    if (modifiers.isNotEmpty && keys.isNotEmpty) {
      final shortcut = '${modifiers.join('+')}+${keys.join('+')}';
      setState(() {
        _recordedShortcut = shortcut.toUpperCase();
      });
    } else if (modifiers.isNotEmpty) {
      // Show partial shortcut while recording
      setState(() {
        _recordedShortcut = '${modifiers.join('+')}+...';
      });
    }
  }

  bool _isModifierKey(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.controlLeft ||
        key == LogicalKeyboardKey.controlRight ||
        key == LogicalKeyboardKey.metaLeft ||
        key == LogicalKeyboardKey.metaRight ||
        key == LogicalKeyboardKey.shiftLeft ||
        key == LogicalKeyboardKey.shiftRight ||
        key == LogicalKeyboardKey.altLeft ||
        key == LogicalKeyboardKey.altRight;
  }

  String _getKeyLabel(LogicalKeyboardKey key) {
    // Modifier keys
    if (key == LogicalKeyboardKey.controlLeft ||
        key == LogicalKeyboardKey.controlRight) {
      return 'CTRL';
    }
    if (key == LogicalKeyboardKey.metaLeft ||
        key == LogicalKeyboardKey.metaRight) {
      return 'CMD';
    }
    if (key == LogicalKeyboardKey.shiftLeft ||
        key == LogicalKeyboardKey.shiftRight) {
      return 'SHIFT';
    }
    if (key == LogicalKeyboardKey.altLeft ||
        key == LogicalKeyboardKey.altRight) {
      return 'ALT';
    }

    // Number keys
    if (key == LogicalKeyboardKey.digit0) return '0';
    if (key == LogicalKeyboardKey.digit1) return '1';
    if (key == LogicalKeyboardKey.digit2) return '2';
    if (key == LogicalKeyboardKey.digit3) return '3';
    if (key == LogicalKeyboardKey.digit4) return '4';
    if (key == LogicalKeyboardKey.digit5) return '5';
    if (key == LogicalKeyboardKey.digit6) return '6';
    if (key == LogicalKeyboardKey.digit7) return '7';
    if (key == LogicalKeyboardKey.digit8) return '8';
    if (key == LogicalKeyboardKey.digit9) return '9';

    // Letter keys
    if (key == LogicalKeyboardKey.keyA) return 'A';
    if (key == LogicalKeyboardKey.keyB) return 'B';
    if (key == LogicalKeyboardKey.keyC) return 'C';
    if (key == LogicalKeyboardKey.keyD) return 'D';
    if (key == LogicalKeyboardKey.keyE) return 'E';
    if (key == LogicalKeyboardKey.keyF) return 'F';
    if (key == LogicalKeyboardKey.keyG) return 'G';
    if (key == LogicalKeyboardKey.keyH) return 'H';
    if (key == LogicalKeyboardKey.keyI) return 'I';
    if (key == LogicalKeyboardKey.keyJ) return 'J';
    if (key == LogicalKeyboardKey.keyK) return 'K';
    if (key == LogicalKeyboardKey.keyL) return 'L';
    if (key == LogicalKeyboardKey.keyM) return 'M';
    if (key == LogicalKeyboardKey.keyN) return 'N';
    if (key == LogicalKeyboardKey.keyO) return 'O';
    if (key == LogicalKeyboardKey.keyP) return 'P';
    if (key == LogicalKeyboardKey.keyQ) return 'Q';
    if (key == LogicalKeyboardKey.keyR) return 'R';
    if (key == LogicalKeyboardKey.keyS) return 'S';
    if (key == LogicalKeyboardKey.keyT) return 'T';
    if (key == LogicalKeyboardKey.keyU) return 'U';
    if (key == LogicalKeyboardKey.keyV) return 'V';
    if (key == LogicalKeyboardKey.keyW) return 'W';
    if (key == LogicalKeyboardKey.keyX) return 'X';
    if (key == LogicalKeyboardKey.keyY) return 'Y';
    if (key == LogicalKeyboardKey.keyZ) return 'Z';

    // Special keys
    if (key == LogicalKeyboardKey.space) return 'SPACE';
    if (key == LogicalKeyboardKey.enter) return 'ENTER';
    if (key == LogicalKeyboardKey.escape) return 'ESC';
    if (key == LogicalKeyboardKey.tab) return 'TAB';
    if (key == LogicalKeyboardKey.backspace) return 'BACKSPACE';

    // Function keys
    if (key == LogicalKeyboardKey.f1) return 'F1';
    if (key == LogicalKeyboardKey.f2) return 'F2';
    if (key == LogicalKeyboardKey.f3) return 'F3';
    if (key == LogicalKeyboardKey.f4) return 'F4';
    if (key == LogicalKeyboardKey.f5) return 'F5';
    if (key == LogicalKeyboardKey.f6) return 'F6';
    if (key == LogicalKeyboardKey.f7) return 'F7';
    if (key == LogicalKeyboardKey.f8) return 'F8';
    if (key == LogicalKeyboardKey.f9) return 'F9';
    if (key == LogicalKeyboardKey.f10) return 'F10';
    if (key == LogicalKeyboardKey.f11) return 'F11';
    if (key == LogicalKeyboardKey.f12) return 'F12';

    // Default fallback
    return key.keyLabel.toUpperCase();
  }

  String _formatShortcutDisplay(String shortcut) {
    return shortcut
        .replaceAll('CMD', '⌘')
        .replaceAll('CTRL', '^')
        .replaceAll('ALT', '⌥')
        .replaceAll('SHIFT', '⇧');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Focus(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        child: ListTile(
          leading: Icon(
            widget.icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(widget.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.subtitle),
              if (_isRecording)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Presiona la combinación de teclas...',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
          trailing: _isRecording
              ? _buildRecordingControls()
              : _buildDisplayControls(),
          onTap: _isRecording ? null : _startRecording,
        ),
      ),
    );
  }

  Widget _buildDisplayControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: Text(
            _formatShortcutDisplay(_recordedShortcut),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.edit,
          size: 20,
          color: Theme.of(context).colorScheme.outline,
        ),
      ],
    );
  }

  Widget _buildRecordingControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Current recording display
        if (_recordedShortcut.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            child: Text(
              _formatShortcutDisplay(_recordedShortcut),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontFamily: 'monospace',
              ),
            ),
          ),

        const SizedBox(width: 4),

        // Stop recording button
        IconButton(
          icon: const Icon(Icons.check, size: 20),
          onPressed:
              _recordedShortcut.isNotEmpty && !_recordedShortcut.contains('...')
              ? _stopRecording
              : null,
          tooltip: 'Confirmar',
          color: Theme.of(context).colorScheme.primary,
        ),

        // Cancel recording button
        IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: _cancelRecording,
          tooltip: 'Cancelar',
          color: Theme.of(context).colorScheme.error,
        ),

        // Reset to default button
        IconButton(
          icon: const Icon(Icons.refresh, size: 20),
          onPressed: _resetToDefault,
          tooltip: 'Restaurar predeterminado',
          color: Theme.of(context).colorScheme.outline,
        ),
      ],
    );
  }
}
