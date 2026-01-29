import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/usecase/params.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_posts_usecase.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/posts_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostsCubit extends Cubit<PostsState> {
  final GetPostsUseCase _getPosts;

  PostsCubit(this._getPosts) : super(const PostsInitial());

  void loadPosts() {
    unawaited(_loadPosts());
  }

  Future<void> _loadPosts() async {
    emit(const PostsLoading());

    final result = await _getPosts(const NoParams());

    switch (result) {
      case Success(:final data):
        emit(PostsLoaded(data));
      case Failure(:final error):
        emit(PostsError(error.message ?? 'Something went wrong'));
    }
  }
}
