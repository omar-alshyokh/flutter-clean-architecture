import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/error/error_mapper.dart';
import 'package:flutter_clean_architecture/core/model/result.dart';

class DioClient {
  final Dio _dio;
  final ErrorMapper _errorMapper;

  DioClient({
    required Dio dio,
    required ErrorMapper errorMapper,
  })  : _dio = dio,
        _errorMapper = errorMapper;

  Dio get instance => _dio;

  Future<Result<Response<T>>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Success(response);
    } catch (e) {
      return Failure(_errorMapper.map(e));
    }
  }

  Future<Result<Response<T>>> post<T>(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Success(response);
    } catch (e) {
      return Failure(_errorMapper.map(e));
    }
  }

  Future<Result<Response<T>>> put<T>(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Success(response);
    } catch (e) {
      return Failure(_errorMapper.map(e));
    }
  }

  Future<Result<Response<T>>> delete<T>(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Success(response);
    } catch (e) {
      return Failure(_errorMapper.map(e));
    }
  }
}
