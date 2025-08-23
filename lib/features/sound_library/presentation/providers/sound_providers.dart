import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/sound.dart';
import '../../domain/usecases/get_all_sounds.dart';
import '../../domain/usecases/add_sound.dart';
import '../../domain/usecases/delete_sound.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/file_helper.dart';
import '../../../../core/util/logger.dart';
import '../state/sound_state.dart';
import '../../../../core/di/injection.dart';

/// Sound notifier class that manages the sound state
class SoundsNotifier extends StateNotifier<SoundsState> {
  final GetAllSounds _getAllSounds;
  final AddSound _addSound;
  final DeleteSound _deleteSound;

  SoundsNotifier(this._getAllSounds, this._addSound, this._deleteSound)
    : super(const SoundsState());

  /// Load all sounds
  Future<void> loadSounds() async {
    Logger().info('Loading sounds from database', tag: 'SOUNDS');
    state = state.copyWith(isLoading: true, error: null);

    final result = await _getAllSounds(const NoParams());

    result.fold(
      (failure) {
        Logger().error('Failed to load sounds', tag: 'SOUNDS', error: failure);
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
      },
      (sounds) async {
        Logger().info(
          'Loaded ${sounds.length} sounds, validating file paths',
          tag: 'SOUNDS',
        );

        // Validate that files still exist and filter out missing ones
        final validSounds = <Sound>[];
        final invalidSounds = <Sound>[];

        for (final sound in sounds) {
          if (FileHelper.fileExists(sound.filePath)) {
            validSounds.add(sound);
            Logger().debug('Sound file exists: ${sound.alias}', tag: 'SOUNDS');
          } else {
            invalidSounds.add(sound);
            Logger().warning(
              'Sound file missing: ${sound.alias} at ${sound.filePath}',
              tag: 'SOUNDS',
            );
          }
        }

        // Remove invalid sounds from database
        if (invalidSounds.isNotEmpty) {
          Logger().info(
            'Removing ${invalidSounds.length} invalid sounds from database',
            tag: 'SOUNDS',
          );
          for (final sound in invalidSounds) {
            if (sound.id != null) {
              await _deleteSound(DeleteSoundParams(id: sound.id!));
              Logger().debug(
                'Removed invalid sound: ${sound.alias}',
                tag: 'SOUNDS',
              );
            }
          }
        }

        Logger().info(
          'Validation complete: ${validSounds.length} valid, ${invalidSounds.length} removed',
          tag: 'SOUNDS',
        );

        state = state.copyWith(
          isLoading: false,
          sounds: validSounds,
          error: null,
        );
      },
    );
  }

  /// Add a new sound
  Future<void> addNewSound(String filePath, String alias) async {
    Logger().info('Adding new sound: $alias at $filePath', tag: 'SOUNDS');
    state = state.copyWith(isLoading: true, error: null);

    // Validate file exists before adding
    if (!FileHelper.fileExists(filePath)) {
      Logger().error(
        'Cannot add sound - file does not exist: $filePath',
        tag: 'SOUNDS',
      );
      state = state.copyWith(
        isLoading: false,
        error: 'El archivo no existe: $filePath',
      );
      return;
    }

    final result = await _addSound(
      AddSoundParams(filePath: filePath, alias: alias),
    );

    result.fold(
      (failure) {
        Logger().error(
          'Failed to add sound: $alias',
          tag: 'SOUNDS',
          error: failure,
        );
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
      },
      (sound) {
        final updatedSounds = [...state.sounds, sound];
        Logger().info(
          'Successfully added sound: $alias (ID: ${sound.id})',
          tag: 'SOUNDS',
        );
        state = state.copyWith(
          isLoading: false,
          sounds: updatedSounds,
          error: null,
        );
      },
    );
  }

  /// Delete a sound
  Future<void> deleteSoundById(int id) async {
    Logger().info('Deleting sound with ID: $id', tag: 'SOUNDS');
    state = state.copyWith(isLoading: true, error: null);

    final result = await _deleteSound(DeleteSoundParams(id: id));

    result.fold(
      (failure) {
        Logger().error(
          'Failed to delete sound with ID: $id',
          tag: 'SOUNDS',
          error: failure,
        );
        state = state.copyWith(
          isLoading: false,
          error: _mapFailureToMessage(failure),
        );
      },
      (_) {
        final updatedSounds = state.sounds
            .where((sound) => sound.id != id)
            .toList();
        Logger().info('Successfully deleted sound with ID: $id', tag: 'SOUNDS');
        state = state.copyWith(
          isLoading: false,
          sounds: updatedSounds,
          error: null,
        );
      },
    );
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(failure) {
    return failure.when(
      serverFailure: (message) => 'Error del servidor: $message',
      cacheFailure: (message) => 'Error de caché: $message',
      fileFailure: (message) => 'Error de archivo: $message',
      databaseFailure: (message) => 'Error de base de datos: $message',
      validationFailure: (message) => 'Error de validación: $message',
      unknownFailure: (message) => 'Error desconocido: $message',
    );
  }
}

/// Provider for the sounds notifier
final soundsProvider = StateNotifierProvider<SoundsNotifier, SoundsState>((
  ref,
) {
  return SoundsNotifier(
    ref.read(getAllSoundsProvider),
    ref.read(addSoundProvider),
    ref.read(deleteSoundProvider),
  );
});
