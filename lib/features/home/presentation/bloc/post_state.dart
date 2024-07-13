part of 'post_bloc.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PostInitial';
}

class PostLoading extends PostState {
  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PostLoading';
}

class GetPostsSuccess extends PostState {
  final List<PostEntity> posts;

  const GetPostsSuccess({required this.posts});

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'GetPostsSuccess';
}

class GetPostsFailed extends PostState {
  final BaseError error;

  const GetPostsFailed({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GetPostsFailed';
}
