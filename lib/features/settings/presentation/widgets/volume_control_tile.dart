import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/util/logger.dart';
import '../../domain/entities/volume_setting.dart';
import '../providers/volume_providers.dart';
import '../providers/settings_database_providers.dart';

/// Widget para controlar el volumen de la aplicación
class VolumeControlTile extends ConsumerWidget {
  const VolumeControlTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the volume initializer to ensure service is initialized
    ref.watch(volumeInitializerProvider);

    final volumeSetting = ref.watch(volumeSettingDatabaseProvider);
    final volumeNotifier = ref.read(volumeSettingDatabaseProvider.notifier);

    return _VolumeControlContent(
      volumeSetting: volumeSetting,
      onVolumeChanged: volumeNotifier.setVolume,
      onMuteToggled: volumeNotifier.toggleMute,
    );
  }
}

/// Internal widget for volume control content
class _VolumeControlContent extends StatelessWidget {
  final VolumeSetting volumeSetting;
  final Function(double) onVolumeChanged;
  final VoidCallback onMuteToggled;

  const _VolumeControlContent({
    required this.volumeSetting,
    required this.onVolumeChanged,
    required this.onMuteToggled,
  });

  @override
  Widget build(BuildContext context) {
    return _VolumeControlWidget(
      volumeSetting: volumeSetting,
      onVolumeChanged: onVolumeChanged,
      onMuteToggled: onMuteToggled,
    );
  }
}

/// Widget implementation for volume control
class _VolumeControlWidget extends StatefulWidget {
  final VolumeSetting volumeSetting;
  final Function(double) onVolumeChanged;
  final VoidCallback onMuteToggled;

  const _VolumeControlWidget({
    required this.volumeSetting,
    required this.onVolumeChanged,
    required this.onMuteToggled,
  });

  @override
  State<_VolumeControlWidget> createState() => _VolumeControlWidgetState();
}

class _VolumeControlWidgetState extends State<_VolumeControlWidget> {
  @override
  void initState() {
    super.initState();
    Logger().info('Volume control widget initialized', tag: 'VOLUME_UI');
  }

  void _setVolume(double volume) {
    Logger().debug('Volume slider changed to: $volume', tag: 'VOLUME_UI');
    widget.onVolumeChanged(volume);
  }

  void _toggleMute() {
    Logger().debug('Mute button toggled', tag: 'VOLUME_UI');
    widget.onMuteToggled();
  }

  @override
  Widget build(BuildContext context) {
    final setting = widget.volumeSetting;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.volume_up,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Control de Volumen',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Controla el volumen de la aplicación',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Volume icon and percentage
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        setting.volumeIcon,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        setting.volumeDescription,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Volume Controls
            Row(
              children: [
                // Mute button
                IconButton(
                  onPressed: _toggleMute,
                  icon: Icon(
                    setting.isMuted ? Icons.volume_off : Icons.volume_up,
                    color: setting.isMuted
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                  ),
                  tooltip: setting.isMuted ? 'Activar sonido' : 'Silenciar',
                ),

                const SizedBox(width: 8),

                // Volume slider
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: setting.isMuted
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.primary,
                      activeTrackColor: setting.isMuted
                          ? Theme.of(context).colorScheme.error.withOpacity(0.3)
                          : Theme.of(context).colorScheme.primary,
                      inactiveTrackColor: Theme.of(
                        context,
                      ).colorScheme.outlineVariant,
                      overlayColor: setting.isMuted
                          ? Theme.of(context).colorScheme.error.withOpacity(0.1)
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.1),
                    ),
                    child: Slider(
                      value: setting.masterVolume,
                      min: 0.0,
                      max: 1.0,
                      divisions: 20,
                      onChanged: _setVolume,
                      label: '${(setting.masterVolume * 100).round()}%',
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Quick volume buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildQuickVolumeButton(
                      icon: Icons.volume_down,
                      volume: 0.3,
                      label: 'Bajo',
                    ),
                    _buildQuickVolumeButton(
                      icon: Icons.volume_up,
                      volume: 0.7,
                      label: 'Alto',
                    ),
                    _buildQuickVolumeButton(
                      icon: Icons.volume_up_outlined,
                      volume: 1.0,
                      label: 'Máximo',
                    ),
                  ],
                ),
              ],
            ),

            // Info indicator
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Este control afecta únicamente el volumen de la aplicación, no el volumen del sistema.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickVolumeButton({
    required IconData icon,
    required double volume,
    required String label,
  }) {
    final setting = widget.volumeSetting;
    final isSelected = (setting.masterVolume - volume).abs() < 0.1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _setVolume(volume),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(
              icon,
              size: 16,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
