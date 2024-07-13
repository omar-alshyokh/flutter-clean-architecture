import 'package:collection/collection.dart';

import 'base_state.dart';

/// This is the initial state for all blocs in the application as
/// a standard state extends the base state class [BaseState].
class BaseInitState extends BaseState {
  /// Holding an optional data when first creating the bloc if any.
  final dynamic initialData;

  const BaseInitState({this.initialData});

  @override
  List<Object?> get props => [initialData];

  @override
  String toString() {
    return 'BaseInitState(initialData: $initialData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const ListEquality().equals;
    return other is BaseInitState &&
        other.initialData == initialData &&
        listEquals(other.props, props);
  }

  @override
  int get hashCode {
    return initialData.hashCode;
  }
}
