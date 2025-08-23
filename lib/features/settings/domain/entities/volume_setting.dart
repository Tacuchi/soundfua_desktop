import 'package:freezed_annotation/freezed_annotation.dart';

part 'volume_setting.freezed.dart';
part 'volume_setting.g.dart';

/// Volume setting entity
@freezed
class VolumeSetting with _$VolumeSetting {
  const factory VolumeSetting({
    @Default(0.7) double masterVolume,
    @Default(false) bool isMuted,
  }) = _VolumeSetting;

  factory VolumeSetting.fromJson(Map<String, dynamic> json) =>
      _$VolumeSettingFromJson(json);
}

/// Extension for volume operations
extension VolumeSettingExtension on VolumeSetting {
  /// Get effective volume (0.0 if muted)
  double get effectiveVolume => isMuted ? 0.0 : masterVolume;

  /// Check if volume is at minimum
  bool get isMinVolume => masterVolume <= 0.0;

  /// Check if volume is at maximum
  bool get isMaxVolume => masterVolume >= 1.0;

  /// Get volume percentage (0-100)
  int get volumePercentage => (masterVolume * 100).round();

  /// Get volume level description
  String get volumeDescription {
    if (isMuted) return 'Silenciado';
    if (isMinVolume) return 'Mínimo';
    if (isMaxVolume) return 'Máximo';
    return '${volumePercentage}%';
  }

  /// Get appropriate volume icon
  String get volumeIcon {
    if (isMuted || isMinVolume) return '🔇';
    if (masterVolume < 0.3) return '🔈';
    if (masterVolume < 0.7) return '🔉';
    return '🔊';
  }
}
