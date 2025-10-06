import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.cache({required String message}) = CacheFailure;
  const factory Failure.file({required String message}) = FileFailure;
  const factory Failure.audio({required String message}) = AudioFailure;
  const factory Failure.validation({required String message}) = ValidationFailure;
  const factory Failure.unknown({required String message}) = UnknownFailure;
}
