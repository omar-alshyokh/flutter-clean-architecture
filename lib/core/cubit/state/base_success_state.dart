
import 'base_state.dart';

class BaseSuccessState extends BaseState {
  /// Holding an optional message requesting or processing.
  final String? message;

  /// Holding an optional data when finishes requesting or processing.
  final dynamic data;

  const BaseSuccessState({this.message, this.data});

  @override
  List<Object?> get props => [message, data];

  @override
  String toString() {
    return 'BaseSuccessState(message: $message, data: $data)';
  }
}
