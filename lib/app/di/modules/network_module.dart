import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/app/config/app_config.dart';
import 'package:flutter_clean_architecture/core/constants/app_constants.dart';
import 'package:flutter_clean_architecture/core/error/error_mapper.dart';
import 'package:flutter_clean_architecture/core/network/dio_client.dart';
import 'package:flutter_clean_architecture/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_clean_architecture/core/network/interceptors/retry_interceptor.dart';
import 'package:injectable/injectable.dart';


@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AppConfig config) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        sendTimeout: AppConstants.sendTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {'Accept': 'application/json'},
      ),
    );

    if (config.isDev || config.isStaging) {
      dio.interceptors.add(const LoggingInterceptor());
    }

    dio.interceptors.add(RetryInterceptor(dio: dio));

    return dio;
  }

  @lazySingleton
  DioClient dioClient(Dio dio, ErrorMapper errorMapper) {
    return DioClient(dio: dio, errorMapper: errorMapper);
  }
}
