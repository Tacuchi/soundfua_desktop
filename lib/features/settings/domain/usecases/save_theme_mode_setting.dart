import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/theme_mode_setting.dart';
import '../repositories/settings_repository.dart';

/// Parameters for saving theme mode setting
class SaveThemeModeParams {
  final AppThemeMode themeMode;

  SaveThemeModeParams({required this.themeMode});
}

/// Use case for saving theme mode setting
class SaveThemeModeSetting implements UseCase<Unit, SaveThemeModeParams> {
  final SettingsRepository repository;

  SaveThemeModeSetting(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SaveThemeModeParams params) async {
    return await repository.saveThemeModeSetting(params.themeMode);
  }
}
