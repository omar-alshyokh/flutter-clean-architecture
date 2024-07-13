
import 'package:dio/dio.dart';
import 'package:starter/core/model/result.dart';
import 'package:starter/features/home/data/models/post_model.dart';

abstract class PostDatasource {
  Future<Result<List<PostModel>>> getPosts(
      {CancelToken? cancelToken});
}