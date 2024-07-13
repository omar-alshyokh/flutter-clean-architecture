

import '../../error/base_error.dart';
import '../../error/unexpacted_error.dart';
import 'base_state.dart';

/// This is the failure state for all blocs in the application as
/// a standard state extends the base state class [BaseState].
/// Related error: []
class BaseFailState extends BaseState {
  /// Holds a specific error that provides some more data about this error.
  final BaseError? error;

  /// Provides the same failed action to try again the same action.
  final void Function()? callback;

  const BaseFailState(this.error, {this.callback});

  factory BaseFailState.ui() => const BaseFailState(UnexpectedError());

  @override
  List<Object?> get props => [
        error
        // , callback
      ];

  @override
  String toString() {
    return 'BaseFailState(error: $error, callback: $callback)';
  }
}
