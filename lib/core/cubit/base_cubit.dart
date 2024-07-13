import 'package:flutter_bloc/flutter_bloc.dart';

/// Basic cubit which is used to be a super class for all cubits in the app.
abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(T state) : super(state);
}