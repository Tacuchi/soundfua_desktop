import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';

abstract class AudioService {
  Future<Either<Failure, void>> playSound(String filePath);
  Future<Either<Failure, void>> stopPlayback();
  Future<Either<Failure, void>> setOutputDevice(String deviceId);
  Future<Either<Failure, void>> setVolume(double volume);
  Future<Either<Failure, double>> getVolume();
  Future<Either<Failure, bool>> isPlaying();
}
