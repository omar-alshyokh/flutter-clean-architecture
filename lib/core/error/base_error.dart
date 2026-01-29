import 'package:equatable/equatable.dart';

abstract class BaseError extends Equatable {
  final String? message;
  final String? code;

  const BaseError({this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}
