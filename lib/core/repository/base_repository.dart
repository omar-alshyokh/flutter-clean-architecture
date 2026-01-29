import 'package:flutter_clean_architecture/core/entity/base_entity.dart';
import 'package:flutter_clean_architecture/core/model/base_model.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';

abstract class BaseRepository {
  const BaseRepository();

  Result<E> execute<M extends BaseModel<E>, E extends BaseEntity>({
    required Result<M> remoteResult,
  }) {
    return switch (remoteResult) {
      Success<M>(:final data) => Success<E>(data.toEntity()),
      Failure<M>(:final error) => Failure<E>(error),
    };
  }

  Result<List<E>> executeForList<M extends BaseModel<E>, E extends BaseEntity>({
    required Result<List<M>> remoteResult,
  }) {
    return switch (remoteResult) {
      Success<List<M>>(:final data) => Success<List<E>>(
        data.map((m) => m.toEntity()).toList(),
      ),
      Failure<List<M>>(:final error) => Failure<List<E>>(error),
    };
  }

  Result<void> executeForNoData({
    required Result<void> remoteResult,
  }) {
    return remoteResult;
  }
}
