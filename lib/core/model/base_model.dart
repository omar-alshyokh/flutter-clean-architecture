import 'package:flutter_clean_architecture/core/entity/base_entity.dart';

abstract class BaseModel<E extends BaseEntity> {
  const BaseModel();

  E toEntity();
}
