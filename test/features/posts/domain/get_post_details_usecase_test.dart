import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_post_details_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_setup.dart';

void main() {
  late PostsRepository repository;
  late GetPostDetailsUseCase useCase;

  setUpAll(registerTestFallbacks);

  setUp(() {
    repository = MockPostsRepository();
    useCase = GetPostDetailsUseCase(repository);
  });

  test('calls repository.getPostById with the provided id', () async {
    const post = PostEntity(id: 1, title: 'Title', body: 'Body', userId: 1);

    when(() => repository.getPostById(1)).thenAnswer((_) async => const Success(post));

    final result = await useCase(const PostIdParams(1));

    expect(result, const Success(post));
    verify(() => repository.getPostById(1)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('returns Failure when repository fails', () async {
    const error = UnknownError(message: 'Something went wrong');

    when(() => repository.getPostById(1)).thenAnswer((_) async => const Failure(error));

    final result = await useCase(const PostIdParams(1));

    expect(result, const Failure<PostEntity>(error));
    verify(() => repository.getPostById(1)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
