import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/app/di/di.dart';
import 'package:flutter_clean_architecture/app/routes/route_paths.dart';
import 'package:flutter_clean_architecture/features/home/presentation/pages/home_page.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/post_details_page.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.home,
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: RoutePaths.posts,
        name: 'posts',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => getIt<PostsCubit>()..loadPosts(),
            child: const PostsPage(),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.postDetails,
        name: 'postDetails',
        builder: (context, state) {
          final idParam = state.pathParameters['id'] ?? '0';
          final id = int.tryParse(idParam) ?? 0;

          return BlocProvider(
            create: (_) => getIt<PostDetailsCubit>()..load(id),
            child: const PostDetailsPage(),
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(child: Text('Page not found')),
      );
    },
  );
}
