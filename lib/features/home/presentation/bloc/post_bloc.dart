import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/core/di/di.dart';
import 'package:starter/core/error/base_error.dart';
import 'package:starter/features/home/domain/entity/post_entity.dart';
import 'package:starter/features/home/domain/repository/post_repository_impl.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<GetPostEvent>(_getPosts);
  }

  final PostRepositoryImpl _repository = findDep<PostRepositoryImpl>();

  void _getPosts(
    GetPostEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());

    final results = await _repository.getPosts(cancelToken: event.cancelToken);

    if (results.hasDataOnly) {
      emit(GetPostsSuccess(posts: results.data!));
    } else {
      emit(GetPostsFailed(error: results.error!));
    }
  }
}
