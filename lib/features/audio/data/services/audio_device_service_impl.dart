import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';
import 'package:soundfua_desktop/features/audio/domain/entities/audio_device.dart';
import 'package:soundfua_desktop/features/audio/domain/services/audio_device_service.dart';

class AudioDeviceServiceImpl implements AudioDeviceService {
  @override
  Future<Either<Failure, List<AudioDevice>>> getAvailableDevices() async {
    try {
      final devices = await _getSystemAudioDevices();
      return Right(devices);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al obtener dispositivos: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, AudioDevice?>> detectVirtualCable() async {
    try {
      final devices = await _getSystemAudioDevices();
      
      final virtualCable = devices.firstWhere(
        (device) => device.isVirtualCable,
        orElse: () => devices.first,
      );

      if (virtualCable.isVirtualCable) {
        return Right(virtualCable);
      }
      
      return const Right(null);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al detectar cable virtual: $e',
      ));
    }
  }

  @override
  Future<Either<Failure, AudioDevice?>> getDefaultDevice() async {
    try {
      final devices = await _getSystemAudioDevices();
      return Right(devices.isNotEmpty ? devices.first : null);
    } catch (e) {
      return Left(Failure.unknown(
        message: 'Error al obtener dispositivo predeterminado: $e',
      ));
    }
  }

  Future<List<AudioDevice>> _getSystemAudioDevices() async {
    final List<AudioDevice> devices = [];

    if (Platform.isMacOS) {
      devices.addAll(await _getMacOSDevices());
    } else if (Platform.isWindows) {
      devices.addAll(await _getWindowsDevices());
    } else if (Platform.isLinux) {
      devices.addAll(await _getLinuxDevices());
    }

    return devices;
  }

  Future<List<AudioDevice>> _getMacOSDevices() async {
    final List<AudioDevice> devices = [];

    try {
      final result = await Process.run('system_profiler', ['SPAudioDataType']);
      final output = result.stdout.toString();

      final deviceNames = <String>[];
      final lines = output.split('\n');
      
      for (var line in lines) {
        if (line.trim().startsWith('_name:') || 
            line.contains('Output Source:')) {
          final match = RegExp(r':\s*(.+)$').firstMatch(line);
          if (match != null) {
            deviceNames.add(match.group(1)!.trim());
          }
        }
      }

      for (var i = 0; i < deviceNames.length; i++) {
        final name = deviceNames[i];
        final isVirtual = _isVirtualCableName(name);
        
        devices.add(AudioDevice(
          id: 'macos_$i',
          name: name,
          isVirtualCable: isVirtual,
        ));
      }
    } catch (e) {
      devices.add(const AudioDevice(
        id: 'default',
        name: 'Default Audio Output',
        isVirtualCable: false,
      ));
    }

    return devices;
  }

  Future<List<AudioDevice>> _getWindowsDevices() async {
    return [
      const AudioDevice(
        id: 'default',
        name: 'Default Audio Output',
        isVirtualCable: false,
      ),
    ];
  }

  Future<List<AudioDevice>> _getLinuxDevices() async {
    final List<AudioDevice> devices = [];

    try {
      final result = await Process.run('pactl', ['list', 'sinks', 'short']);
      final output = result.stdout.toString();
      
      final lines = output.split('\n');
      for (var line in lines) {
        if (line.trim().isEmpty) continue;
        
        final parts = line.split('\t');
        if (parts.length >= 2) {
          final id = parts[0];
          final name = parts[1];
          final isVirtual = _isVirtualCableName(name);
          
          devices.add(AudioDevice(
            id: 'linux_$id',
            name: name,
            isVirtualCable: isVirtual,
          ));
        }
      }
    } catch (e) {
      devices.add(const AudioDevice(
        id: 'default',
        name: 'Default Audio Output',
        isVirtualCable: false,
      ));
    }

    return devices;
  }

  bool _isVirtualCableName(String name) {
    final nameLower = name.toLowerCase();
    
    final virtualCableKeywords = [
      'blackhole',
      'vb-audio',
      'vb-cable',
      'virtual audio cable',
      'loopback',
      'soundflower',
      'null',
      'dummy',
    ];

    return virtualCableKeywords.any((keyword) => nameLower.contains(keyword));
  }
}
