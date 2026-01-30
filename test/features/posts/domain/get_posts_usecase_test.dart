import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/usecase/params.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_setup.dart';

void main() {
  late PostsRepository repository;
  late GetPostsUseCase useCase;

  setUpAll(registerTestFallbacks);

  setUp(() {
    repository = MockPostsRepository();
    useCase = GetPostsUseCase(repository);
  });

  test('returns Success(List<PostEntity>) when repository succeeds', () async {
    final posts = <PostEntity>[
      const PostEntity(id: 1, title: 'Title', body: 'Body', userId: 1),
    ];

    when(() => repository.getPosts()).thenAnswer((_) async => Success(posts));

    final result = await useCase(const NoParams());

    expect(result, Success(posts));
    verify(() => repository.getPosts()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('returns Failure when repository fails', () async {
    const error = UnknownError(message: 'Something went wrong');

    when(() => repository.getPosts()).thenAnswer((_) async => const Failure(error));

    final result = await useCase(const NoParams());

    expect(result, const Failure<List<PostEntity>>(error));
    verify(() => repository.getPosts()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
