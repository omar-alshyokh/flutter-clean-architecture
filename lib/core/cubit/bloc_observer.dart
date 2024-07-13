// ignore_for_file: avoid_print

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:starter/core/utils/app_utils.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    appPrint('SimpleBlocObserver onTransition $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    appPrint('SimpleBlocObserver onError $error');
    super.onError(bloc, error, stackTrace);
  }
}
