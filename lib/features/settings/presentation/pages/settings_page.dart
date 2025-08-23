import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/theme_mode_setting.dart';
import '../providers/settings_database_providers.dart';
import '../widgets/theme_mode_tile.dart';
import '../widgets/hotkey_recorder_tile.dart';
import '../widgets/volume_control_tile.dart';
import '../../../../core/util/logger.dart';

/// Settings page
class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  void initState() {
    super.initState();
    Logger().info('SettingsPage initialized', tag: 'SETTINGS_UI');
  }

  @override
  Widget build(BuildContext context) {
    // Watch settings initializer to ensure database is ready
    ref.watch(settingsInitializerProvider);

    final themeModeSetting = ref.watch(themeModeSettingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section
            _buildSectionHeader(context, 'Apariencia', Icons.palette),
            const SizedBox(height: 8),
            _buildThemeModeSection(context, themeModeSetting),

            const SizedBox(height: 32),

            // Volume Control Section
            _buildSectionHeader(context, 'Control de Volumen', Icons.volume_up),
            const SizedBox(height: 8),
            _buildVolumeControlSection(context),

            const SizedBox(height: 24),

            // Keyboard Shortcuts Section
            _buildSectionHeader(context, 'Atajos de Teclado', Icons.keyboard),
            const SizedBox(height: 8),
            _buildKeyboardShortcutsSection(context),

            const SizedBox(height: 32),

            // App Info Section
            _buildSectionHeader(context, 'Información de la App', Icons.info),
            const SizedBox(height: 8),
            _buildAppInfoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeModeSection(
    BuildContext context,
    ThemeModeSetting themeModeSetting,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.brightness_6,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Tema'),
              subtitle: Text(
                'Personaliza la apariencia de la aplicación',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Divider(),
            ...AppThemeMode.values.map(
              (themeMode) => ThemeModeTile(
                themeMode: themeMode,
                isSelected: themeModeSetting.themeMode == themeMode,
                onTap: () => _onThemeModeChanged(themeMode),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppInfoSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.music_note,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Gestor de Biblioteca de Sonidos'),
              subtitle: const Text('Versión 1.0.0'),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.description,
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: const Text('Descripción'),
              subtitle: const Text(
                'Aplicación para gestionar y reproducir tu biblioteca personal de sonidos',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeControlSection(BuildContext context) {
    return const VolumeControlTile();
  }

  Widget _buildKeyboardShortcutsSection(BuildContext context) {
    final keyboardShortcutSetting = ref.watch(currentKeyboardShortcutsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.keyboard_command_key,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Atajos de Teclado'),
              subtitle: Text(
                'Configura los atajos para acceso rápido',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Divider(),
            HotkeyRecorderTile(
              title: 'Sonidos Rápidos',
              subtitle: 'Abrir overlay de selección de sonidos',
              currentShortcut: keyboardShortcutSetting.quickSoundsShortcut,
              onShortcutChanged: (shortcut) {
                ref
                    .read(keyboardShortcutSettingProvider.notifier)
                    .updateQuickSoundsShortcut(shortcut);
              },
              icon: Icons.music_note,
            ),
          ],
        ),
      ),
    );
  }

  void _onThemeModeChanged(AppThemeMode themeMode) {
    Logger().info('Theme mode changed to: $themeMode', tag: 'SETTINGS_UI');
    ref.read(themeModeSettingProvider.notifier).updateThemeMode(themeMode);
  }
}
