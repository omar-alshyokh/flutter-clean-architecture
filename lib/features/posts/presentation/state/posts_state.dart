import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

final class PostsInitial extends PostsState {
  const PostsInitial();
}

final class PostsLoading extends PostsState {
  const PostsLoading();
}

final class PostsLoaded extends PostsState {
  final List<PostEntity> posts;

  const PostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

final class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object?> get props => [message];
}
