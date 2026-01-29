import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/usecase/params.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:injectable/injectable.dart';

class PostIdParams extends Params {
  final int id;
  const PostIdParams(this.id);

  @override
  List<Object?> get props => [id];
}

@injectable
class GetPostDetailsUseCase extends UseCase<PostEntity, PostIdParams> {
  final PostsRepository _repository;

  const GetPostDetailsUseCase(this._repository);

  @override
  Future<Result<PostEntity>> call(PostIdParams params) {
    return _repository.getPostById(params.id);
  }
}
