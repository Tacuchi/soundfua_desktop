import 'package:dartz/dartz.dart';
import 'package:media_kit/media_kit.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/features/audio/domain/services/audio_service.dart';

class AudioServiceImpl implements AudioService {
  final Player _player = Player();
  double _volume = 1.0;

  AudioServiceImpl() {
    _player.setVolume(_volume * 100);
  }

  @override
  Future<Either<Failure, void>> playSound(String filePath) async {
    try {
      await _player.open(Media(filePath));
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al reproducir audio: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> stopPlayback() async {
    try {
      await _player.stop();
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al detener reproducción: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> setOutputDevice(String deviceId) async {
    try {
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al establecer dispositivo de salida: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> setVolume(double volume) async {
    try {
      if (volume < 0.0 || volume > 1.0) {
        return Left(Failure.unknown(
          message: 'El volumen debe estar entre 0.0 y 1.0',
        ));
      }
      
      _volume = volume;
      await _player.setVolume(_volume * 100);
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al establecer volumen: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, double>> getVolume() async {
    try {
      return Right(_volume);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al obtener volumen: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> isPlaying() async {
    try {
      return Right(_player.state.playing);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al verificar estado de reproducción: $e',
      ));
    }
  }

  void dispose() {
    _player.dispose();
  }
}
