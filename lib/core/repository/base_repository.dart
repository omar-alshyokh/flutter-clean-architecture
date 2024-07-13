// Project imports:


import 'package:starter/core/entity/base_entity.dart';
import 'package:starter/core/model/base_model.dart';
import 'package:starter/core/model/result.dart';

abstract class BaseRepository {
  const BaseRepository();

  Result<Entity>
      execute<Model extends BaseModel, Entity extends BaseEntity>({
    required Result<Model> remoteResult,
  }) {
    if (remoteResult.hasDataOnly) {
      return Result(
        data: remoteResult.data!.toEntity() as Entity,
      );
    } else {
      return Result(error: remoteResult.error);
    }
  }

  Result<List<Entity>> executeForList<Model extends BaseModel<Entity>,
      Entity extends BaseEntity>({required Result<List<Model>> remoteResult}) {
    if (remoteResult.hasDataOnly) {
      return Result(
        data: remoteResult.data!.map((model) => model.toEntity()).toList(),
      );
    } else {
      return Result(error: remoteResult.error);
    }
  }

  Result<Object> executeForNoData({
    required Result<Object> remoteResult,
  }) {
    if (remoteResult.hasDataOnly) {
      return const Result(data: Object());
    }
    return Result(error: remoteResult.error);
  }
}
