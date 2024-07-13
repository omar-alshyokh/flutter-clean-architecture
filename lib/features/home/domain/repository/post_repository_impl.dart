import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/core/model/result.dart';
import 'package:starter/core/repository/base_repository.dart';
import 'package:starter/features/home/data/datasources/post_datasource.dart';
import 'package:starter/features/home/data/models/post_model.dart';
import 'package:starter/features/home/domain/entity/post_entity.dart';
import 'package:starter/features/home/domain/repository/post_repository.dart';

@LazySingleton()
class PostRepositoryImpl extends BaseRepository implements PostRepository {
  PostDatasource _datasource;

  PostRepositoryImpl(this._datasource);

  @override
  Future<Result<List<PostEntity>>> getPosts({
    CancelToken? cancelToken,
  }) async {
    final result = await _datasource.getPosts();
    return executeForList<PostModel, PostEntity>(remoteResult: result);
  }
}
