import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.serverFailure(String message) = ServerFailure;
  const factory Failure.cacheFailure(String message) = CacheFailure;
  const factory Failure.fileFailure(String message) = FileFailure;
  const factory Failure.databaseFailure(String message) = DatabaseFailure;
  const factory Failure.validationFailure(String message) = ValidationFailure;
  const factory Failure.unknownFailure(String message) = UnknownFailure;
}
