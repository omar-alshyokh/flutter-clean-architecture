import 'package:equatable/equatable.dart';
import 'package:starter/core/error/base_error.dart';

class Result<Data> extends Equatable {
  final Data? data;
  final BaseError? error;

  const Result({this.data, this.error}) : assert(data != null || error != null);

  bool get hasDataOnly => data != null && error == null;

  bool get hasErrorOnly => data == null && error != null;

  bool get hasDataAndError => data != null && error != null;

  Future<Result<Data>> toFuture() => Future.value(this);

  @override
  List<Object?> get props => [data, error];
}