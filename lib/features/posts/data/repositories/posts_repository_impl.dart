import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/repository/base_repository.dart';
import 'package:flutter_clean_architecture/features/posts/data/datasources/posts_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: PostsRepository)
class PostsRepositoryImpl extends BaseRepository implements PostsRepository {
  final PostsRemoteDataSource _remote;

  const PostsRepositoryImpl(this._remote);

  @override
  Future<Result<List<PostEntity>>> getPosts() async {
    final remoteResult = await _remote.fetchPosts();
    return executeForList<PostModel, PostEntity>(remoteResult: remoteResult);
  }
}
