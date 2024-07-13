import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/core/model/result.dart';
import 'package:starter/features/home/data/datasources/post_datasource.dart';
import 'package:starter/features/home/data/datasources/post_local_datasource.dart';
import 'package:starter/features/home/data/datasources/post_remote_datasource.dart';
import 'package:starter/features/home/data/models/post_model.dart';

@LazySingleton(as: PostDatasource)
class PostDatasourceImpl extends PostDatasource {
  PostLocalDataSource _localDataSource;
  PostRemoteDataSource _remoteDataSource;

  PostDatasourceImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Result<List<PostModel>>> getPosts({CancelToken? cancelToken}) {
    return _remoteDataSource.getPosts();
  }
}
