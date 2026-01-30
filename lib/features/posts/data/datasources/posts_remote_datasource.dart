import 'package:flutter_clean_architecture/core/datasource/base_remote_datasource.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/network/endpoints.dart';
import 'package:flutter_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:injectable/injectable.dart';

abstract class PostsRemoteDataSource {
  const PostsRemoteDataSource();

  Future<Result<List<PostModel>>> fetchPosts();

  Future<Result<PostModel>> fetchPostById(int id);
}

@LazySingleton(as: PostsRemoteDataSource)
class PostsRemoteDataSourceImpl extends BaseRemoteDataSource implements PostsRemoteDataSource {
  PostsRemoteDataSourceImpl(super.client);

  @override
  Future<Result<List<PostModel>>> fetchPosts() {
    return getList<PostModel>(
      path: Endpoints.posts,
      fromJson: PostModel.fromJson,
    );
  }

  @override
  Future<Result<PostModel>> fetchPostById(int id) {
    return getObject<PostModel>(
      path: Endpoints.postById(id),
      fromJson: PostModel.fromJson,
    );
  }
}
