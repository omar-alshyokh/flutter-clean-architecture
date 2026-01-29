import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/presentation/layout/screen_wrapper.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/empty_view.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/error_view.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/loading_view.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: ScreenWrapper(
        scrollable: false,
        child: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            return switch (state) {
              PostsInitial() => const SizedBox.shrink(),
              PostsLoading() => const LoadingView(),
              PostsError(:final message) => ErrorView(
                message: message,
                onRetry: () => context.read<PostsCubit>().loadPosts(),
              ),
              PostsLoaded(:final posts) =>
                posts.isEmpty
                    ? const EmptyView(message: 'No posts found')
                    : RefreshIndicator(
                        onRefresh: () => context.read<PostsCubit>().loadPosts(),
                        child: ListView.separated(
                          itemCount: posts.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return ListTile(
                              title: Text(
                                post.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                post.body,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          },
                        ),
                      ),
            };
          },
        ),
      ),
    );
  }
}
