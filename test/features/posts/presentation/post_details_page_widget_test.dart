import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/error_view.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/loading_view.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_state.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/posts_test_app.dart';

void main() {
  late MockPostsCubit postsCubit;
  late MockPostDetailsCubit detailsCubit;

  setUp(() {
    postsCubit = MockPostsCubit();
    detailsCubit = MockPostDetailsCubit();
  });

  tearDown(() async {
    await postsCubit.close();
    await detailsCubit.close();
  });

  testWidgets('shows LoadingView when state is PostDetailsLoading', (tester) async {
    // Posts cubit not used, but required for router
    when(() => postsCubit.state).thenReturn(const PostsInitial());
    whenListen(
      postsCubit,
      const Stream<PostsState>.empty(),
      initialState: const PostsInitial(),
    );

    when(() => detailsCubit.state).thenReturn(const PostDetailsLoading());
    whenListen(
      detailsCubit,
      Stream<PostDetailsState>.value(const PostDetailsLoading()),
      initialState: const PostDetailsLoading(),
    );

    await tester.pumpWidget(
      buildPostsTestApp(
        postsCubit: postsCubit,
        detailsCubit: detailsCubit,
        initialLocation: '/posts/1',
      ),
    );
    await tester.pump();

    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('shows ErrorView when state is PostDetailsError', (tester) async {
    when(() => postsCubit.state).thenReturn(const PostsInitial());
    whenListen(
      postsCubit,
      const Stream<PostsState>.empty(),
      initialState: const PostsInitial(),
    );

    when(() => detailsCubit.state).thenReturn(const PostDetailsError('failed'));
    whenListen(
      detailsCubit,
      Stream<PostDetailsState>.value(const PostDetailsError('failed')),
      initialState: const PostDetailsError('failed'),
    );

    await tester.pumpWidget(
      buildPostsTestApp(
        postsCubit: postsCubit,
        detailsCubit: detailsCubit,
        initialLocation: '/posts/1',
      ),
    );
    await tester.pump();

    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
  });

  testWidgets('shows title and body when state is PostDetailsLoaded', (tester) async {
    const post = PostEntity(
      id: 1,
      title: 'My title',
      body: 'My body',
      userId: 1,
    );

    when(() => postsCubit.state).thenReturn(const PostsInitial());
    whenListen(
      postsCubit,
      const Stream<PostsState>.empty(),
      initialState: const PostsInitial(),
    );

    when(() => detailsCubit.state).thenReturn(const PostDetailsLoaded(post));
    whenListen(
      detailsCubit,
      Stream<PostDetailsState>.value(const PostDetailsLoaded(post)),
      initialState: const PostDetailsLoaded(post),
    );

    await tester.pumpWidget(
      buildPostsTestApp(
        postsCubit: postsCubit,
        detailsCubit: detailsCubit,
        initialLocation: '/posts/1',
      ),
    );
    await tester.pump();

    expect(find.text('My title'), findsOneWidget);
    expect(find.text('My body'), findsOneWidget);
  });
}
