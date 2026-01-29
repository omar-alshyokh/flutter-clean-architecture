import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/usecase/params.dart';

abstract class UseCase<T, P extends Params> {
  const UseCase();

  Future<Result<T>> call(P params);
}

abstract class UseCaseNoParams<T> extends UseCase<T, NoParams> {
  const UseCaseNoParams();
}
