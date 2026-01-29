import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/features/posts/domain/entities/post_entity.dart';

sealed class PostDetailsState extends Equatable {
  const PostDetailsState();
  @override
  List<Object?> get props => [];
}

final class PostDetailsInitial extends PostDetailsState {
  const PostDetailsInitial();
}

final class PostDetailsLoading extends PostDetailsState {
  const PostDetailsLoading();
}

final class PostDetailsLoaded extends PostDetailsState {
  final PostEntity post;
  const PostDetailsLoaded(this.post);

  @override
  List<Object?> get props => [post];
}

final class PostDetailsError extends PostDetailsState {
  final String message;
  const PostDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
