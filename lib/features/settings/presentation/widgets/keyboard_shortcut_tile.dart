import 'package:flutter/material.dart';
import '../../../../core/util/logger.dart';

/// Tile widget for configuring keyboard shortcuts
class KeyboardShortcutTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String currentShortcut;
  final Function(String) onShortcutChanged;
  final IconData icon;

  const KeyboardShortcutTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentShortcut,
    required this.onShortcutChanged,
    this.icon = Icons.keyboard,
  });

  @override
  State<KeyboardShortcutTile> createState() => _KeyboardShortcutTileState();
}

class _KeyboardShortcutTileState extends State<KeyboardShortcutTile> {
  bool _isEditing = false;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.currentShortcut;
  }

  @override
  void didUpdateWidget(KeyboardShortcutTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentShortcut != widget.currentShortcut) {
      _controller.text = widget.currentShortcut;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    });
    Logger().debug('Started editing keyboard shortcut', tag: 'SETTINGS_UI');
  }

  void _saveShortcut() {
    final newShortcut = _controller.text.trim().toUpperCase();
    if (newShortcut.isNotEmpty && newShortcut != widget.currentShortcut) {
      Logger().info(
        'Saving new keyboard shortcut: $newShortcut',
        tag: 'SETTINGS_UI',
      );
      widget.onShortcutChanged(newShortcut);
    }
    _cancelEditing();
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
    _controller.text = widget.currentShortcut;
    Logger().debug('Cancelled editing keyboard shortcut', tag: 'SETTINGS_UI');
  }

  void _resetToDefault() {
    Logger().info('Resetting keyboard shortcut to default', tag: 'SETTINGS_UI');
    widget.onShortcutChanged('CMD+0');
    _cancelEditing();
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
      child: ListTile(
        leading: Icon(
          widget.icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        trailing: _isEditing
            ? _buildEditingControls()
            : _buildDisplayControls(),
        onTap: _isEditing ? null : _startEditing,
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
            _formatShortcutDisplay(widget.currentShortcut),
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

  Widget _buildEditingControls() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              border: OutlineInputBorder(),
            ),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
            textAlign: TextAlign.center,
            onSubmitted: (_) => _saveShortcut(),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: const Icon(Icons.check, size: 20),
          onPressed: _saveShortcut,
          tooltip: 'Guardar',
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: _cancelEditing,
          tooltip: 'Cancelar',
        ),
        IconButton(
          icon: const Icon(Icons.refresh, size: 20),
          onPressed: _resetToDefault,
          tooltip: 'Restaurar predeterminado',
        ),
      ],
    );
  }
}
