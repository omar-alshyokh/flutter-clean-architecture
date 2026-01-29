import 'package:flutter_clean_architecture/core/entity/base_entity.dart';

class EmptyResultEntity extends BaseEntity {
  final String message;

  const EmptyResultEntity({required this.message});

  @override
  List<Object?> get props => [message];
}

class DynamicResultEntity extends BaseEntity {
  final Object? data;

  const DynamicResultEntity({required this.data});

  @override
  List<Object?> get props => [data];
}
