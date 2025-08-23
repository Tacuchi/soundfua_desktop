import 'package:flutter/material.dart';
import '../../domain/entities/theme_mode_setting.dart';

/// Widget for theme mode selection tile
class ThemeModeTile extends StatelessWidget {
  final AppThemeMode themeMode;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemeModeTile({
    super.key,
    required this.themeMode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        themeMode.icon,
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      ),
      title: Text(
        themeMode.displayName,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      subtitle: Text(_getSubtitle()),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Theme.of(
        context,
      ).colorScheme.primary.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  String _getSubtitle() {
    switch (themeMode) {
      case AppThemeMode.light:
        return 'Usar tema claro siempre';
      case AppThemeMode.dark:
        return 'Usar tema oscuro siempre';
      case AppThemeMode.system:
        return 'Seguir configuración del sistema';
    }
  }
}
