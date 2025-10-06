import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundfua_desktop/features/audio/presentation/providers/audio_providers.dart';
import 'package:url_launcher/url_launcher.dart';

class AudioSettingsSection extends ConsumerWidget {
  const AudioSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(availableAudioDevicesProvider);
    final selectedDevice = ref.watch(selectedAudioDeviceProvider);
    final volume = ref.watch(audioVolumeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuración de Audio',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dispositivo de Salida',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                
                if (selectedDevice != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedDevice.isVirtualCable
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          selectedDevice.isVirtualCable
                              ? Icons.cable
                              : Icons.speaker,
                          color: selectedDevice.isVirtualCable
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedDevice.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              if (selectedDevice.isVirtualCable)
                                Text(
                                  'Cable Virtual Detectado',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer.withAlpha(76),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_outlined,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text('No hay dispositivo seleccionado'),
                        ),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _showDeviceSelector(context, ref, devicesAsync);
                      },
                      icon: const Icon(Icons.settings_input_component),
                      label: const Text('Seleccionar Dispositivo'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await ref
                            .read(selectedAudioDeviceProvider.notifier)
                            .autoDetectVirtualCable();
                      },
                      icon: const Icon(Icons.autorenew),
                      label: const Text('Auto-detectar Cable Virtual'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Volumen',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${(volume * 100).round()}%',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Slider(
                  value: volume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 100,
                  label: '${(volume * 100).round()}%',
                  onChanged: (value) {
                    ref.read(audioVolumeProvider.notifier).setVolume(value);
                  },
                ),
                Text(
                  'Ajusta el volumen de reproducción de la aplicación',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        const _VirtualCableGuideCard(),
      ],
    );
  }

  void _showDeviceSelector(
    BuildContext context,
    WidgetRef ref,
    AsyncValue devicesAsync,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Dispositivo de Audio'),
        content: SizedBox(
          width: 400,
          child: devicesAsync.when(
            data: (devices) => ListView.builder(
              shrinkWrap: true,
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return ListTile(
                  leading: Icon(
                    device.isVirtualCable ? Icons.cable : Icons.speaker,
                    color: device.isVirtualCable
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  title: Text(device.name),
                  subtitle: device.isVirtualCable
                      ? const Text('Cable Virtual')
                      : null,
                  onTap: () {
                    ref
                        .read(selectedAudioDeviceProvider.notifier)
                        .selectDevice(device);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Text('Error al cargar dispositivos'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}

class _VirtualCableGuideCard extends StatelessWidget {
  const _VirtualCableGuideCard();

  @override
  Widget build(BuildContext context) {
    String title;
    String description;
    String downloadUrl;
    
    if (Platform.isMacOS) {
      title = 'BlackHole (macOS)';
      description = 'Cable de audio virtual gratuito y open source para macOS';
      downloadUrl = 'https://existential.audio/blackhole/';
    } else if (Platform.isWindows) {
      title = 'VB-Audio Cable (Windows)';
      description = 'Cable de audio virtual para Windows';
      downloadUrl = 'https://vb-audio.com/Cable/';
    } else {
      title = 'PulseAudio (Linux)';
      description = 'Dispositivo virtual de audio para Linux';
      downloadUrl = 'https://www.freedesktop.org/wiki/Software/PulseAudio/';
    }

    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  '¿Necesitas un Cable Virtual?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Para usar esta aplicación con Discord, Zoom u otras apps de comunicación, necesitas instalar un cable de audio virtual.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.download,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(downloadUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              icon: const Icon(Icons.open_in_new),
              label: const Text('Descargar'),
            ),
          ],
        ),
      ),
    );
  }
}
