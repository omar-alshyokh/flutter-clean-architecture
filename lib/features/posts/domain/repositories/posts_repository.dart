import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';

abstract class PostsRepository {
  const PostsRepository();

  Future<Result<List<PostEntity>>> getPosts();

  Future<Result<PostEntity>> getPostById(int id);
}
