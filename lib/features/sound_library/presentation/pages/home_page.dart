import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/sound_providers.dart';
import '../widgets/sound_grid.dart';
import '../widgets/add_sound_dialog.dart';
import '../../../../core/util/logger.dart';
import '../../../../core/util/file_helper.dart';
import '../../../settings/presentation/pages/settings_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load sounds when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Logger().info('HomePage initialized - loading sounds', tag: 'HOME');
      ref.read(soundsProvider.notifier).loadSounds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final soundsState = ref.watch(soundsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Biblioteca de Sonidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Ajustes',
            onPressed: () => _navigateToSettings(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Error message
          if (soundsState.error != null)
            Container(
              width: double.infinity,
              color: Colors.red.shade100,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.error, color: Colors.red.shade700),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      soundsState.error!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      // Clear error by reloading
                      ref.read(soundsProvider.notifier).loadSounds();
                    },
                  ),
                ],
              ),
            ),

          // Main content
          Expanded(
            child: soundsState.isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Cargando sonidos...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : soundsState.sounds.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.library_music, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No hay sonidos en la biblioteca',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Toca el botón + para agregar tu primer sonido',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Formatos soportados: ${FileHelper.supportedAudioFormats.join(', ')}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                : SoundGrid(sounds: soundsState.sounds),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddSoundDialog(context);
        },
        tooltip: 'Agregar sonido',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSoundDialog(BuildContext context) {
    Logger().info('Opening add sound dialog', tag: 'HOME');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddSoundDialog(
          onSoundAdded: (filePath, alias) {
            Logger().info(
              'Sound added from dialog - adding to library',
              tag: 'HOME',
            );
            ref.read(soundsProvider.notifier).addNewSound(filePath, alias);
          },
        );
      },
    );
  }

  void _navigateToSettings(BuildContext context) {
    Logger().info('Navigating to settings page', tag: 'HOME');
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const SettingsPage()));
  }
}
