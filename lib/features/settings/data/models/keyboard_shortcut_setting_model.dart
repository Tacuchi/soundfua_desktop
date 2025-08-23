import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/keyboard_shortcut_setting.dart';

part 'keyboard_shortcut_setting_model.freezed.dart';
part 'keyboard_shortcut_setting_model.g.dart';

/// Keyboard shortcut setting model for data layer
@freezed
class KeyboardShortcutSettingModel with _$KeyboardShortcutSettingModel {
  const factory KeyboardShortcutSettingModel({
    @Default('CMD+0') String quickSoundsShortcut,
  }) = _KeyboardShortcutSettingModel;

  factory KeyboardShortcutSettingModel.fromJson(Map<String, dynamic> json) =>
      _$KeyboardShortcutSettingModelFromJson(json);

  /// Convert from domain entity to model
  factory KeyboardShortcutSettingModel.fromEntity(
    KeyboardShortcutSetting entity,
  ) {
    return KeyboardShortcutSettingModel(
      quickSoundsShortcut: entity.quickSoundsShortcut,
    );
  }
}

/// Extension to convert between model and entity
extension KeyboardShortcutSettingModelExtension
    on KeyboardShortcutSettingModel {
  /// Convert model to entity
  KeyboardShortcutSetting toEntity() {
    return KeyboardShortcutSetting(quickSoundsShortcut: quickSoundsShortcut);
  }
}

/// Extension to convert from entity to model
extension KeyboardShortcutSettingEntityExtension on KeyboardShortcutSetting {
  /// Convert entity to model
  KeyboardShortcutSettingModel toModel() {
    return KeyboardShortcutSettingModel(
      quickSoundsShortcut: quickSoundsShortcut,
    );
  }
}
