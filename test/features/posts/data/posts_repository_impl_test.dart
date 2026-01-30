import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_architecture/features/posts/data/repositories/posts_repository_impl.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

void main() {
  late MockPostsRemoteDataSource remote;
  late PostsRepositoryImpl repository;

  setUp(() {
    remote = MockPostsRemoteDataSource();
    repository = PostsRepositoryImpl(remote);
  });

  group('getPosts', () {
    test('maps models to entities when remote succeeds', () async {
      final models = <PostModel>[
        const PostModel(id: 1, title: 'Title', body: 'Body', userId: 1),
      ];

      when(() => remote.fetchPosts()).thenAnswer((_) async => Success(models));

      final result = await repository.getPosts();

      expect(result.isSuccess, true);
    });

    test('returns failure when remote fails', () async {
      const error = NetworkConnectionError(message: 'no internet');

      when(() => remote.fetchPosts()).thenAnswer((_) async => const Failure(error));

      final result = await repository.getPosts();

      expect(result, isA<Failure>());
    });
  });

  group('getPostById', () {
    test('returns Success(PostEntity) when remote succeeds', () async {
      const model = PostModel(id: 1, title: 'Title', body: 'Body', userId: 1);

      when(() => remote.fetchPostById(1)).thenAnswer((_) async => const Success(model));

      final result = await repository.getPostById(1);

      expect(
        result,
        const Success<PostEntity>(
          PostEntity(id: 1, title: 'Title', body: 'Body', userId: 1),
        ),
      );
      verify(() => remote.fetchPostById(1)).called(1);
      verifyNoMoreInteractions(remote);
    });

    test('returns Failure when remote fails', () async {
      const error = UnknownError(message: 'Something went wrong');

      when(() => remote.fetchPostById(1)).thenAnswer((_) async => const Failure(error));

      final result = await repository.getPostById(1);

      expect(result, const Failure<PostEntity>(error));
      verify(() => remote.fetchPostById(1)).called(1);
      verifyNoMoreInteractions(remote);
    });
  });
}
