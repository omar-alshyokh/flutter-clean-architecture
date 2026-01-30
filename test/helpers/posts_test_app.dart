import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/post_details_page.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_cubit.dart';
import 'package:go_router/go_router.dart';

Widget buildPostsTestApp({
  required PostsCubit postsCubit,
  required PostDetailsCubit detailsCubit,
  String initialLocation = '/posts',
}) {
  final router = GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/posts',
        builder: (context, state) => BlocProvider.value(
          value: postsCubit,
          child: const PostsPage(),
        ),
      ),
      GoRoute(
        path: '/posts/:id',
        builder: (context, state) {
          final idStr = state.pathParameters['id'] ?? '0';
          final id = int.tryParse(idStr) ?? 0;

          return BlocProvider.value(
            value: detailsCubit,
            child: PostDetailsPage(postId: id),
          );
        },
      ),
    ],
  );

  return MaterialApp.router(routerConfig: router);
}
