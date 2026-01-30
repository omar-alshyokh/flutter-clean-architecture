import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/usecase/params.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/test_setup.dart';

void main() {
  late GetPostsUseCase useCase;

  setUpAll(registerTestFallbacks);

  setUp(() {
    useCase = MockGetPostsUseCase();
  });

  blocTest<PostsCubit, PostsState>(
    'emits [Loading, Loaded] when loadPosts succeeds',
    build: () {
      when(() => useCase(const NoParams())).thenAnswer(
        (_) async => const Success(<PostEntity>[
          PostEntity(id: 1, title: 'Title', body: 'Body', userId: 1),
        ]),
      );
      return PostsCubit(useCase);
    },
    act: (cubit) => cubit.loadPosts(),
    expect: () => [
      const PostsLoading(),
      isA<PostsLoaded>(),
    ],
  );

  blocTest<PostsCubit, PostsState>(
    'emits [Loading, Error] when loadPosts fails',
    build: () {
      when(() => useCase(const NoParams())).thenAnswer(
        (_) async => const Failure(UnknownError(message: 'Oops')),
      );
      return PostsCubit(useCase);
    },
    act: (cubit) => cubit.loadPosts(),
    expect: () => [
      const PostsLoading(),
      isA<PostsError>(),
    ],
  );
}
