import 'package:dio/dio.dart';
import 'package:starter/core/model/result.dart';
import 'package:starter/features/home/domain/entity/post_entity.dart';

abstract class PostRepository {
  Future<Result<List<PostEntity>>> getPosts({CancelToken? cancelToken});
}