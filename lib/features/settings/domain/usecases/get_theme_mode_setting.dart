import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/theme_mode_setting.dart';
import '../repositories/settings_repository.dart';

/// Use case for getting theme mode setting
class GetThemeModeSetting implements UseCase<ThemeModeSetting, NoParams> {
  final SettingsRepository repository;

  GetThemeModeSetting(this.repository);

  @override
  Future<Either<Failure, ThemeModeSetting>> call(NoParams params) async {
    return await repository.getThemeModeSetting();
  }
}
