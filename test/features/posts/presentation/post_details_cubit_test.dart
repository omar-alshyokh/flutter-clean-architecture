import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_post_details_usecase.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';

void main() {
  late GetPostDetailsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(const PostIdParams(1));
  });

  setUp(() {
    useCase = MockGetPostDetailsUseCase();
  });

  blocTest<PostDetailsCubit, PostDetailsState>(
    'emits [Loading, Loaded] when load succeeds',
    build: () {
      const post = PostEntity(id: 1, title: 'Title', body: 'Body', userId: 1);

      when(() => useCase(const PostIdParams(1))).thenAnswer((_) async => const Success(post));

      return PostDetailsCubit(useCase);
    },
    act: (cubit) => cubit.load(1),
    expect: () => [
      const PostDetailsLoading(),
      const PostDetailsLoaded(PostEntity(id: 1, title: 'Title', body: 'Body', userId: 1)),
    ],
    verify: (_) {
      verify(() => useCase(const PostIdParams(1))).called(1);
      verifyNoMoreInteractions(useCase);
    },
  );

  blocTest<PostDetailsCubit, PostDetailsState>(
    'emits [Loading, Error] when load fails',
    build: () {
      when(() => useCase(const PostIdParams(1))).thenAnswer(
        (_) async => const Failure(
          UnknownError(message: 'fail'),
        ),
      );

      return PostDetailsCubit(useCase);
    },
    act: (cubit) => cubit.load(1),
    expect: () => [
      const PostDetailsLoading(),
      const PostDetailsError('fail'),
    ],
  );
}
