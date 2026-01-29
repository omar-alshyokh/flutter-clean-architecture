import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/app/di/di.dart';
import 'package:flutter_clean_architecture/app/routes/route_paths.dart';
import 'package:flutter_clean_architecture/features/home/presentation/pages/home_page.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/posts_page.dart';
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
    ],
    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(child: Text('Page not found')),
      );
    },
  );
}
