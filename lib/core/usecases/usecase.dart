import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Base class for all use cases
/// [ReturnType] is the type of the return data
/// [Params] is the type of the input parameters
abstract class UseCase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

/// Used for use cases that don't require parameters
class NoParams {
  const NoParams();
}
