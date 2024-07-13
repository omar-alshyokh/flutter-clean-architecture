// Dart imports:

// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/core/model/result.dart';
import 'package:starter/core/utils/app_utils.dart';
import 'package:starter/core/managers/network/error_handler.dart';

// Project imports:


@Singleton()
class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio);

  static String appendBearerForToken([String? token]) {
    return 'Bearer $token';
  }

  // Get:-----------------------------------------------------------------------
  Future<Result<BaseModel>> get<BaseModel>(
      String uri, {
        required BaseModel Function(dynamic) converter,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      BaseModel r = converter(response.data);
      return Result(data: r);
    } catch (error, stack) {
      appPrint('DioClient get error: $error \nstackTrace: $stack');
      return Result(error: ErrorHandler.handle(error, stack));
    }
  }

  // Get List:-----------------------------------------------------------------------
  Future<Result<List<T>>> getList<T>(
      String uri, {
        Options? options,
        CancelToken? cancelToken,
        required T Function(Map<String, dynamic>) converter,
        Map<String, dynamic>? queryParameters,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        uri,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      final List<dynamic> dataList = response.data as List<dynamic>;
      final result = dataList.map((json) => converter(json as Map<String, dynamic>)).toList();
      return Result(data: result);
    } catch (error, stack) {
      appPrint('DioClient getList error: $error \nstackTrace: $stack');
      return Result(error: ErrorHandler.handle(error, stack));
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Result<BaseModel>> post<BaseModel>(
      String uri, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        BaseModel Function(Map<String, dynamic>)? converter,
        BaseModel Function(dynamic)? converterDynamic,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      BaseModel r;
      if (converterDynamic != null) {
        r = converterDynamic(response.data);
      } else {
        r = converter!(response.data);
      }
      return Result(data: r);
    } catch (error, stack) {
      appPrint('DioClient post error: $error \nstackTrace: $stack');
      return Result(error: ErrorHandler.handle(error, stack));
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Result<BaseModel>> put<BaseModel>(
      String uri, {
        data,
        BaseModel Function(dynamic)? converter,
        BaseModel Function(dynamic)? converterDynamic,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      BaseModel r;
      if (converterDynamic != null) {
        r = converterDynamic(response.data);
      } else {
        r = converter!(response.data);
      }
      return Result(data: r);
    } catch (error, stack) {
      appPrint('DioClient put error: $error \nstackTrace: $stack');
      return Result(error: ErrorHandler.handle(error, stack));
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Result<BaseModel>> delete<BaseModel>(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        BaseModel Function(Map<String, dynamic>)? converter,
        BaseModel Function(dynamic)? converterDynamic,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      BaseModel r;
      if (converterDynamic != null) {
        r = converterDynamic(response.data);
      } else {
        r = converter!(response.data);
      }
      return Result(data: r);
    } catch (error, stack) {
      appPrint('DioClient delete error: $error \nstackTrace: $stack');
      return Result(error: ErrorHandler.handle(error, stack));
    }
  }
}
