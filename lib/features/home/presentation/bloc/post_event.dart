part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {}

class GetPostEvent extends PostEvent {
  final CancelToken cancelToken;

  GetPostEvent(this.cancelToken);

  @override
  List<Object?> get props => [cancelToken];
}
