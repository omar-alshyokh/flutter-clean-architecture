import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/usecase/params.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPostsUseCase extends UseCase<List<PostEntity>, NoParams> {
  final PostsRepository _repository;

  const GetPostsUseCase(this._repository);

  @override
  Future<Result<List<PostEntity>>> call(NoParams params) {
    return _repository.getPosts();
  }
}
