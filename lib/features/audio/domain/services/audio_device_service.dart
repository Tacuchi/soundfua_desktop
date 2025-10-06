import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/features/audio/domain/entities/audio_device.dart';

abstract class AudioDeviceService {
  Future<Either<Failure, List<AudioDevice>>> getAvailableDevices();
  Future<Either<Failure, AudioDevice?>> detectVirtualCable();
  Future<Either<Failure, AudioDevice?>> getDefaultDevice();
}
