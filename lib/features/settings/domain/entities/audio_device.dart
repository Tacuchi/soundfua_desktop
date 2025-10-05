import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_device.freezed.dart';
part 'audio_device.g.dart';

/// Entity representing an audio output device
@freezed
class AudioDevice with _$AudioDevice {
  const factory AudioDevice({
    /// Unique identifier for the device
    required String id,

    /// Human-readable name of the device
    required String name,

    /// Whether this is a virtual audio cable (VB-CABLE, etc.)
    @Default(false) bool isVirtualCable,

    /// Whether this is the system default device
    @Default(false) bool isDefault,

    /// Whether this is currently selected in the app
    @Default(false) bool isSelected,
  }) = _AudioDevice;

  factory AudioDevice.fromJson(Map<String, dynamic> json) =>
      _$AudioDeviceFromJson(json);
}

/// Extension methods for AudioDevice
extension AudioDeviceX on AudioDevice {
  /// Check if device name contains keywords that suggest it's a virtual cable
  bool get looksLikeVirtualCable {
    if (isVirtualCable) return true;

    final nameLower = name.toLowerCase();
    final virtualCableKeywords = [
      'cable',
      'virtual',
      'vb-audio',
      'vb audio',
      'voicemeeter',
      'vac', // Virtual Audio Cable
      'vban',
      'line',
      'stereo mix',
      'soundboard',
    ];

    return virtualCableKeywords.any((keyword) => nameLower.contains(keyword));
  }

  /// Get a user-friendly description for this device
  String get description {
    final parts = <String>[];

    if (isVirtualCable || looksLikeVirtualCable) {
      parts.add('Virtual Audio Cable');
    }

    if (isDefault) {
      parts.add('Default');
    }

    if (isSelected) {
      parts.add('Selected');
    }

    return parts.isEmpty ? '' : parts.join(' • ');
  }

  /// Get an appropriate icon for this device type
  String get iconEmoji {
    if (isVirtualCable || looksLikeVirtualCable) {
      return '📢'; // Virtual cable icon
    } else if (name.toLowerCase().contains('headphone') ||
        name.toLowerCase().contains('headset')) {
      return '🎧'; // Headphones
    } else if (name.toLowerCase().contains('speaker')) {
      return '🔊'; // Speakers
    } else if (name.toLowerCase().contains('bluetooth')) {
      return '📡'; // Bluetooth
    } else {
      return '🎵'; // Generic audio device
    }
  }
}
