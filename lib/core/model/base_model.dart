// Project imports:

import 'package:starter/core/entity/base_entity.dart';

abstract class BaseModel<T extends BaseEntity> {
  const BaseModel();

  T toEntity();

  /// FNV-1a 64bit hash algorithm optimized for Dart Strings
  int fastHash(String string) {
    var hash = 0xcbf29ce;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
