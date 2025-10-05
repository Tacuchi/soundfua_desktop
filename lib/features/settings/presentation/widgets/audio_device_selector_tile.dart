import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/audio_device.dart';
import '../providers/audio_device_providers.dart';
import '../../../../core/util/logger.dart';
import '../../../../core/di/injection.dart';

/// Widget for selecting audio output device
class AudioDeviceSelectorTile extends ConsumerWidget {
  const AudioDeviceSelectorTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDevice = ref.watch(audioDeviceNotifierProvider);
    final devicesAsync = ref.watch(audioDevicesProvider);
    final hasVirtualCable = ref.watch(hasVirtualCableProvider);
    final recommendedMessage = ref.watch(recommendedDeviceMessageProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.volume_up, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Dispositivo de Audio',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current device display
            if (selectedDevice != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      selectedDevice.iconEmoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedDevice.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          if (selectedDevice.description.isNotEmpty)
                            Text(
                              selectedDevice.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withOpacity(0.7),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle, color: Colors.green),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ] else ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.speaker, size: 24),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Dispositivo predeterminado del sistema',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Auto-detect button (if virtual cables available)
            if (hasVirtualCable) ...[
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _autoDetectVirtualCable(context, ref),
                  icon: const Icon(Icons.cable),
                  label: const Text('Auto-detectar Virtual Cable'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Devices list
            devicesAsync.when(
              data: (devices) {
                if (devices.isEmpty) {
                  return _buildNoDevicesMessage(context);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Dispositivos disponibles (${devices.length})',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...devices.map((device) => _buildDeviceTile(
                          context,
                          ref,
                          device,
                          selectedDevice,
                        )),
                  ],
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => _buildErrorMessage(context, error),
            ),

            // Info message
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    hasVirtualCable ? Icons.info : Icons.warning,
                    size: 20,
                    color: hasVirtualCable ? Colors.blue : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      recommendedMessage,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceTile(
    BuildContext context,
    WidgetRef ref,
    AudioDevice device,
    AudioDevice? selectedDevice,
  ) {
    final isSelected = selectedDevice?.id == device.id;
    final isVirtual = device.isVirtualCable || device.looksLikeVirtualCable;

    return ListTile(
      leading: Text(
        device.iconEmoji,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        device.name,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 13,
        ),
      ),
      subtitle: device.description.isNotEmpty
          ? Text(
              device.description,
              style: const TextStyle(fontSize: 11),
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isVirtual)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple),
              ),
              child: const Text(
                'VIRTUAL',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          const SizedBox(width: 8),
          if (isSelected)
            const Icon(Icons.check_circle, color: Colors.green)
          else
            const Icon(Icons.radio_button_unchecked),
        ],
      ),
      onTap: () => _selectDevice(context, ref, device),
      selected: isSelected,
      selectedTileColor:
          Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildNoDevicesMessage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.speaker_phone,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 8),
          const Text(
            'No se encontraron dispositivos de audio',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            'Verifica la configuración de audio de tu sistema',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context, Object error) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.error,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 8),
          const Text(
            'Error al cargar dispositivos',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            error.toString(),
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _selectDevice(
    BuildContext context,
    WidgetRef ref,
    AudioDevice device,
  ) async {
    try {
      Logger().info('User selected device: ${device.name}', tag: 'SETTINGS');

      // Save device selection
      await ref.read(audioDeviceNotifierProvider.notifier).selectDevice(device);

      // Apply device to MultiAudioService
      final multiAudioService = ref.read(multiAudioServiceProvider);
      await multiAudioService.setDevice(device);

      // Show confirmation
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Text(device.iconEmoji),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('Dispositivo seleccionado: ${device.name}'),
                ),
              ],
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to select device',
        tag: 'SETTINGS',
        error: e,
        stackTrace: stackTrace,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al seleccionar dispositivo'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _autoDetectVirtualCable(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      Logger().info('Auto-detecting virtual cable', tag: 'SETTINGS');

      final success =
          await ref.read(audioDeviceNotifierProvider.notifier).autoDetectAndSelect();

      if (!success) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se detectó ningún cable virtual'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        return;
      }

      // Get the selected device
      final selectedDevice = ref.read(audioDeviceNotifierProvider);
      if (selectedDevice != null) {
        // Apply to MultiAudioService
        final multiAudioService = ref.read(multiAudioServiceProvider);
        await multiAudioService.setDevice(selectedDevice);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Cable virtual detectado: ${selectedDevice.name}',
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e, stackTrace) {
      Logger().error(
        'Failed to auto-detect virtual cable',
        tag: 'SETTINGS',
        error: e,
        stackTrace: stackTrace,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al detectar cable virtual'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
