import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/presentation/layout/screen_wrapper.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/error_view.dart';
import 'package:flutter_clean_architecture/core/presentation/widgets/loading_view.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_state.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: ScreenWrapper(
        scrollable: false,
        child: BlocBuilder<PostDetailsCubit, PostDetailsState>(
          builder: (context, state) {
            return switch (state) {
              PostDetailsInitial() => const SizedBox.shrink(),
              PostDetailsLoading() => const LoadingView(),
              PostDetailsError(:final message) => ErrorView(message: message),
              PostDetailsLoaded(:final post) => ListView(
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(post.body),
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}
