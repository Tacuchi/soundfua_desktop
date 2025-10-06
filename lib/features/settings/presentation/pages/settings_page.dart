import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundfua_desktop/features/overlay/presentation/providers/sound_providers.dart';

class SettingsPage extends ConsumerWidget {
  final bool isStandaloneWindow;
  
  const SettingsPage({super.key, this.isStandaloneWindow = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFolder = ref.watch(selectedFolderPathProvider);
    final soundsState = ref.watch(soundsNotifierProvider);
    final soundsCountAsync = ref.watch(soundsCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // No mostrar botón de retroceso en ventana independiente
        automaticallyImplyLeading: !isStandaloneWindow,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biblioteca de Sonidos',
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
                      'Carpeta de Audios',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    if (selectedFolder != null)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.folder,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                selectedFolder,
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text('No hay carpeta seleccionada'),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            final path = await FilePicker.platform
                                .getDirectoryPath();
                            if (path != null) {
                              ref
                                  .read(selectedFolderPathProvider.notifier)
                                  .state = path;
                            }
                          },
                          icon: const Icon(Icons.folder_open),
                          label: const Text('Seleccionar Carpeta'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: selectedFolder == null ||
                                  soundsState.maybeWhen(
                                    syncing: () => true,
                                    orElse: () => false,
                                  )
                              ? null
                              : () {
                                  ref
                                      .read(soundsNotifierProvider.notifier)
                                      .syncFolder(selectedFolder);
                                },
                          icon: soundsState.maybeWhen(
                            syncing: () => const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            orElse: () => const Icon(Icons.sync),
                          ),
                          label: const Text('Sincronizar'),
                        ),
                      ],
                    ),
                    soundsState.maybeWhen(
                      error: (message) => Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .errorContainer
                                  .withAlpha(76),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estadísticas',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    soundsCountAsync.when(
                      data: (count) => Row(
                        children: [
                          Icon(
                            Icons.audiotrack,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '$count ${count == 1 ? 'sonido' : 'sonidos'} en la biblioteca',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      loading: () => const Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('Cargando...'),
                        ],
                      ),
                      error: (_, __) => const Row(
                        children: [
                          Icon(Icons.error_outline),
                          SizedBox(width: 12),
                          Text('Error al cargar contador'),
                        ],
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
}
