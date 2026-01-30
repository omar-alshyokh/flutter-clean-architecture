import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_post_details_usecase.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/state/post_details_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostDetailsCubit extends Cubit<PostDetailsState> {
  final GetPostDetailsUseCase _useCase;

  PostDetailsCubit(this._useCase) : super(const PostDetailsInitial());

  void load(int id) {
    unawaited(_load(id));
  }

  Future<void> _load(int id) async {
    emit(const PostDetailsLoading());

    final result = await _useCase(PostIdParams(id));

    switch (result) {
      case Success(:final data):
        emit(PostDetailsLoaded(data));
      case Failure(:final error):
        emit(PostDetailsError(error.message ?? 'Something went wrong'));
    }
  }
}
