import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/core/constants/app_constants.dart';
import 'package:flutter_clean_architecture/core/error/error_mapper.dart';
import 'package:flutter_clean_architecture/core/network/dio_client.dart';
import 'package:flutter_clean_architecture/core/network/endpoints.dart';
import 'package:flutter_clean_architecture/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_clean_architecture/core/network/interceptors/retry_interceptor.dart';
import 'package:injectable/injectable.dart';


@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        sendTimeout: AppConstants.sendTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {'Accept': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      const LoggingInterceptor(),
      RetryInterceptor(dio: dio),
    ]);

    return dio;
  }

  @lazySingleton
  DioClient dioClient(Dio dio, ErrorMapper errorMapper) {
    return DioClient(dio: dio, errorMapper: errorMapper);
  }
}
