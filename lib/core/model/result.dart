import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/core/error/base_error.dart';

sealed class Result<T> extends Equatable {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
}

final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);

  @override
  List<Object?> get props => [data];
}

final class Failure<T> extends Result<T> {
  final BaseError error;

  const Failure(this.error);

  @override
  List<Object?> get props => [error];
}
