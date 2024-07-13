import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utils/app_utils.dart';

/// Abstract class to handle caching.
/// Each box contains a core value, i.e. the reason the caching exists.
/// By default, when calling [put], the value will be stored in [defaultKey] unless otherwise stated
/// using key parameter.
abstract class BoxHandler<T> {
  /// The box where data is stored.
  Future<Box> get box;

  /// A key to be used for [put] & [get] if key isn't stated.
  String get defaultKey;

  /// Adds [value] of [key] (or [defaultKey]) in [boxName]
  @mustCallSuper
  Future<void> put(T value, {String? key}) async {
    final openBox = await box;
    final now = DateTime.now().toIso8601String();
    openBox.put('updatedAt', now);
    if (!openBox.containsKey('createdAt')) {
      openBox.put('createdAt', now);
    }
  }

  /// Retrieves a previously cached value of [key] (or [defaultKey]) from [boxName]
  Future<T> get({String? key});

  /// Deletes the value of [key]
  Future<void> delete({String? key}) async {
    final now = DateTime.now().toIso8601String();
    final openBox = await box;
    await openBox.delete(key ?? defaultKey);
    await openBox.put('updatedAt', now);
  }
}

abstract class CollectionBoxHandler<T> extends BoxHandler<T> {
  /// Inserts [value] to the collection only if it does not exist.
  ///
  /// [T] is compared using `bool operator ==(other)`.
  /// So, for custom objects, T must override the equality behaviour using `bool operator ==(other)`.
  ///
  /// Read more: https://work.j832.com/2014/05/equality-and-dart.html
  /// https://api.dart.dev/be/137051/dart-core/Object/operator_equals.html
  Future<void> put(T value, {String? key});

  /// Deletes [value] from the list of [key].
  ///
  /// Note: The data type of [key] must be iterable.
  void deleteValue(T value, {String? key});

  /// Deletes value in [index] from the list of [key].
  ///
  /// Note: The data type of [key] must be iterable.
  void deleteAt(int index, {String? key});
}

abstract class ListBoxHandler<T> extends CollectionBoxHandler<List<T>> {
  @override
  Future<void> deleteValue(Iterable<T> value, {String? key}) async {
    var existingValue = await get();
    final valueList = existingValue.toList();
    for (final item in value) {
      final x = valueList.remove(item);
      appPrint('ListBoxHandler.deleteValue result: $x');
    }
    final openBox = await box;
    openBox.put(key ?? defaultKey, valueList);
    super.put(valueList, key: key ?? defaultKey);
  }

  @override
  Future<void> deleteAt(int index, {String? key}) async {
    final existingValue = await get();
    if (index >= 0 && index < existingValue.length) {
      existingValue.toList().removeAt(index);
    }
    put(existingValue, key: key ?? defaultKey);
  }
}
