import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';
import 'package:flutter_clean_architecture/core/network/dio_client.dart';

abstract class BaseRemoteDataSource {
  final DioClient client;

  const BaseRemoteDataSource(this.client);

  Future<Result<List<T>>> getList<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final result = await client.get<dynamic>(
      path,
      queryParameters: queryParameters,
    );

    return switch (result) {
      Success(:final data) => _parseList(data.data, fromJson),
      Failure(:final error) => Failure(error),
    };
  }

  Future<Result<T>> getObject<T>({
    required String path,
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    final result = await client.get<dynamic>(
      path,
      queryParameters: queryParameters,
    );

    return switch (result) {
      Success(:final data) => _parseObject(data.data, fromJson),
      Failure(:final error) => Failure(error),
    };
  }

  Future<Result<void>> postNoData({
    required String path,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final result = await client.post<dynamic>(
      path,
      data: body,
      queryParameters: queryParameters,
    );

    return switch (result) {
      Success() => const Success(null),
      Failure(:final error) => Failure(error),
    };
  }

  Result<List<T>> _parseList<T>(
    dynamic raw,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (raw is List) {
      final list = <T>[];
      for (final item in raw) {
        if (item is Map<String, dynamic>) {
          list.add(fromJson(item));
        }
      }
      return Success(list);
    }
    return const Failure(UnknownError(message: 'Invalid response format'));
  }

  Result<T> _parseObject<T>(
    dynamic raw,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (raw is Map<String, dynamic>) {
      return Success(fromJson(raw));
    }
    return const Failure(UnknownError(message: 'Invalid response format'));
  }
}
