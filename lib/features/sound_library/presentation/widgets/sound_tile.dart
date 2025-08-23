import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/sound.dart';
import '../providers/sound_providers.dart';
import '../providers/multi_audio_providers.dart';
import '../../../../core/util/logger.dart';

class SoundTile extends ConsumerWidget {
  final Sound sound;

  const SoundTile({super.key, required this.sound});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Logger().uiDebug(
      'Building SoundTile for: ${sound.alias}',
      widget: 'SoundTile',
    );

    final multiAudioPlayerState = ref.watch(multiAudioPlayerProvider);
    final multiAudioPlayerNotifier = ref.read(
      multiAudioPlayerProvider.notifier,
    );

    final isCurrentFile = multiAudioPlayerState.hasActiveInstancesForFile(
      sound.filePath,
    );
    final isPlaying = multiAudioPlayerState.isFileCurrentlyPlaying(
      sound.filePath,
    );
    final playingCount = multiAudioPlayerState.getPlayingInstancesCount(
      sound.filePath,
    );

    Logger().uiDebug(
      'SoundTile state - isCurrentFile: $isCurrentFile, isPlaying: $isPlaying, playingCount: $playingCount',
      widget: 'SoundTile',
    );

    return Card(
      elevation: 2, // Reduced elevation for cleaner look
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: GestureDetector(
        onSecondaryTapDown: (details) {
          _showContextMenu(context, ref, details.globalPosition);
        },
        child: InkWell(
          onTap: () async {
            try {
              Logger().uiDebug(
                'SoundTile tapped - starting playback overlay',
                widget: 'SoundTile',
              );
              await multiAudioPlayerNotifier.playAudio(sound.filePath);
              Logger().uiDebug(
                'SoundTile playback started successfully',
                widget: 'SoundTile',
              );
            } catch (e, stackTrace) {
              Logger().uiError(
                'Error in SoundTile onTap',
                widget: 'SoundTile',
                error: e,
                stackTrace: stackTrace,
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error al reproducir "${sound.alias}": $e'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            }
          },
          child: Container(
            height: 72, // Standard Material Design list item height
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Status icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCurrentFile && isPlaying
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                        : Theme.of(context).colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCurrentFile && isPlaying
                        ? Icons.play_arrow
                        : isCurrentFile
                        ? Icons.pause
                        : Icons.play_arrow_outlined,
                    color: isCurrentFile && isPlaying
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 16),

                // Content - takes remaining space
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        sound.alias,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isCurrentFile
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Status
                      Text(
                        isCurrentFile && isPlaying
                            ? 'Reproduciendo'
                            : isCurrentFile
                            ? 'En pausa'
                            : 'Listo',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                // Play count badge (if multiple instances)
                if (playingCount > 1)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$playingCount',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show context menu on right click
  void _showContextMenu(
    BuildContext context,
    WidgetRef ref,
    Offset globalPosition,
  ) {
    Logger().uiDebug(
      'Showing context menu for: ${sound.alias}',
      widget: 'SoundTile',
    );

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        globalPosition.dx,
        globalPosition.dy,
        globalPosition.dx + 1,
        globalPosition.dy + 1,
      ),
      items: [
        PopupMenuItem(
          value: 'delete',
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.delete, color: Colors.red, size: 16),
              SizedBox(width: 8),
              Text('Eliminar', style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        Logger().uiDebug('Context menu - delete selected', widget: 'SoundTile');
        _showDeleteConfirmation(context, ref);
      }
    });
  }

  /// Show delete confirmation dialog
  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Estás seguro de que quieres eliminar "${sound.alias}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (sound.id != null) {
                ref.read(soundsProvider.notifier).deleteSoundById(sound.id!);
                Logger().info('Sound deleted via context menu: ${sound.alias}');
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
