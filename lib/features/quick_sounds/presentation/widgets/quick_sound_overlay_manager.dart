import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/util/logger.dart';
import '../providers/quick_sound_providers.dart';
import 'quick_sound_overlay.dart';

/// Widget that manages the quick sound overlay display
class QuickSoundOverlayManager extends ConsumerWidget {
  const QuickSoundOverlayManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize the quick sound system
    ref.watch(quickSoundInitializerProvider);

    final quickSoundService = ref.watch(quickSoundServiceProvider);
    final isVisible = ref.watch(quickSoundOverlayVisibilityProvider);
    final selectedIndex = ref.watch(quickSoundSelectedIndexProvider);
    final currentSounds = ref.watch(quickSoundCurrentSoundsProvider);

    Logger().debug(
      'QuickSoundOverlayManager build called',
      tag: 'QUICK_SOUNDS_UI',
    );

    return isVisible.when(
      data: (visible) {
        if (!visible) return const SizedBox.shrink();

        return selectedIndex.when(
          data: (index) {
            return currentSounds.when(
              data: (sounds) {
                Logger().debug(
                  'Showing overlay with ${sounds.length} sounds, selected: $index',
                  tag: 'QUICK_SOUNDS_UI',
                );
                return QuickSoundOverlay(
                  sounds: sounds,
                  selectedIndex: index,
                  quickSoundService: quickSoundService,
                );
              },
              loading: () => _buildLoadingOverlay(context),
              error: (error, stack) {
                Logger().error(
                  'Error loading sounds for overlay',
                  tag: 'QUICK_SOUNDS_UI',
                  error: error,
                  stackTrace: stack,
                );
                return _buildErrorOverlay(context, error.toString());
              },
            );
          },
          loading: () => _buildLoadingOverlay(context),
          error: (error, stack) {
            Logger().error(
              'Error getting selected index',
              tag: 'QUICK_SOUNDS_UI',
              error: error,
              stackTrace: stack,
            );
            return _buildErrorOverlay(context, error.toString());
          },
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) {
        Logger().error(
          'Error getting overlay visibility',
          tag: 'QUICK_SOUNDS_UI',
          error: error,
          stackTrace: stack,
        );
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingOverlay(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.1),
        child: Center(
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'Cargando sonidos...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorOverlay(BuildContext context, String error) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.1),
        child: Center(
          child: Container(
            width: 300,
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Theme.of(context).colorScheme.error,
                    size: 32,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
