import 'package:dartz/dartz.dart';
import 'package:soundfua_desktop/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
