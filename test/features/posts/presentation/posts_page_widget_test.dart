import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/empty_view.dart';
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

  testWidgets('shows LoadingView when state is PostsLoading', (tester) async {
    when(() => postsCubit.state).thenReturn(const PostsLoading());
    whenListen(
      postsCubit,
      Stream<PostsState>.value(const PostsLoading()),
      initialState: const PostsLoading(),
    );

    // Details cubit isn't used in this scenario, but app needs it for routes
    when(() => detailsCubit.state).thenReturn(const PostDetailsInitial());
    whenListen(
      detailsCubit,
      const Stream<PostDetailsState>.empty(),
      initialState: const PostDetailsInitial(),
    );

    await tester.pumpWidget(
      buildPostsTestApp(postsCubit: postsCubit, detailsCubit: detailsCubit),
    );
    await tester.pump();

    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('shows ErrorView when state is PostsError', (tester) async {
    when(() => postsCubit.state).thenReturn(const PostsError('failed'));
    whenListen(
      postsCubit,
      Stream<PostsState>.value(const PostsError('failed')),
      initialState: const PostsError('failed'),
    );

    when(() => detailsCubit.state).thenReturn(const PostDetailsInitial());
    whenListen(
      detailsCubit,
      const Stream<PostDetailsState>.empty(),
      initialState: const PostDetailsInitial(),
    );

    await tester.pumpWidget(
      buildPostsTestApp(postsCubit: postsCubit, detailsCubit: detailsCubit),
    );
    await tester.pump();

    expect(find.byType(ErrorView), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
  });

  testWidgets('shows EmptyView when PostsLoaded has empty list', (tester) async {
    when(() => postsCubit.state).thenReturn(const PostsLoaded(<PostEntity>[]));
    whenListen(
      postsCubit,
      Stream<PostsState>.value(const PostsLoaded(<PostEntity>[])),
      initialState: const PostsLoaded(<PostEntity>[]),
    );

    when(() => detailsCubit.state).thenReturn(const PostDetailsInitial());
    whenListen(
      detailsCubit,
      const Stream<PostDetailsState>.empty(),
      initialState: const PostDetailsInitial(),
    );

    await tester.pumpWidget(
      buildPostsTestApp(postsCubit: postsCubit, detailsCubit: detailsCubit),
    );
    await tester.pump();

    expect(find.byType(EmptyView), findsOneWidget);
    expect(find.text('No posts found'), findsOneWidget);
  });

  testWidgets('shows list items when PostsLoaded has data', (tester) async {
    final posts = <PostEntity>[
      const PostEntity(id: 1, title: 'Hello', body: 'Body 1', userId: 1),
      const PostEntity(id: 2, title: 'World', body: 'Body 2', userId: 1),
    ];

    when(() => postsCubit.state).thenReturn(PostsLoaded(posts));
    whenListen(
      postsCubit,
      Stream<PostsState>.value(PostsLoaded(posts)),
      initialState: PostsLoaded(posts),
    );

    when(() => detailsCubit.state).thenReturn(const PostDetailsInitial());
    whenListen(
      detailsCubit,
      const Stream<PostDetailsState>.empty(),
      initialState: const PostDetailsInitial(),
    );

    await tester.pumpWidget(
      buildPostsTestApp(postsCubit: postsCubit, detailsCubit: detailsCubit),
    );
    await tester.pump();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('World'), findsOneWidget);
  });

  testWidgets('tapping a post navigates to details page', (tester) async {
    final posts = <PostEntity>[
      const PostEntity(id: 7, title: 'Tap me', body: 'Body', userId: 1),
    ];

    when(() => postsCubit.state).thenReturn(PostsLoaded(posts));
    whenListen(
      postsCubit,
      Stream<PostsState>.value(PostsLoaded(posts)),
      initialState: PostsLoaded(posts),
    );

    // When we navigate, PostDetailsPage will be shown and will read detailsCubit.state
    when(() => detailsCubit.state).thenReturn(
      const PostDetailsLoaded(
        PostEntity(id: 7, title: 'Detail title', body: 'Detail body', userId: 1),
      ),
    );
    whenListen(
      detailsCubit,
      Stream<PostDetailsState>.value(
        const PostDetailsLoaded(
          PostEntity(id: 7, title: 'Detail title', body: 'Detail body', userId: 1),
        ),
      ),
      initialState: const PostDetailsLoaded(
        PostEntity(id: 7, title: 'Detail title', body: 'Detail body', userId: 1),
      ),
    );

    await tester.pumpWidget(
      buildPostsTestApp(postsCubit: postsCubit, detailsCubit: detailsCubit),
    );
    await tester.pump();

    await tester.tap(find.text('Tap me'));
    await tester.pumpAndSettle();

    expect(find.text('Detail title'), findsOneWidget);
    expect(find.text('Detail body'), findsOneWidget);
  });
}
