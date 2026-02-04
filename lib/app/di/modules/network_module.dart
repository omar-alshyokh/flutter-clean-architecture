import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture/app/config/app_config.dart';
import 'package:flutter_clean_architecture/core/constants/app_constants.dart';
import 'package:flutter_clean_architecture/core/error/error_mapper.dart';
import 'package:flutter_clean_architecture/core/network/dio_client.dart';
import 'package:flutter_clean_architecture/core/network/interceptors/network_logging_interceptor.dart';
import 'package:flutter_clean_architecture/core/network/interceptors/retry_interceptor.dart';
import 'package:flutter_clean_architecture/core/network/pinning/pinning_http_client_adapter.dart';
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

    if (config.enableCertificatePinning) {
      final hasPins = config.spkiPinsByHost.isNotEmpty &&
          config.spkiPinsByHost.values.every((pins) => pins.isNotEmpty);

      if (!hasPins) {
        throw StateError(
          'Certificate pinning is enabled but no pins were provided. '
              'Expected --dart-define PINNING_JSON with host->pins map.',
        );
      }

      dio.httpClientAdapter = buildPinnedAdapter(config);
    }

    if (config.isDev || config.isStaging) {
      dio.interceptors.add(
        NetworkLoggingInterceptor(
          logRequestHeaders: false,
          logRequestBody: true,
          logResponseBody: true,
          logResponseHeaders: false,
        ),
      );
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, h) {
          // This will show HandshakeException / SocketException details
          if (kDebugMode) {
            debugPrint('PINNING ERROR type=${e.type}');
            debugPrint('PINNING ERROR message=${e.message}');
            debugPrint('PINNING ERROR error=${e.error}');
          }
          h.next(e);
        },
      ),
    );

    dio.interceptors.add(RetryInterceptor(dio: dio));
    return dio;
  }

  @lazySingleton
  DioClient dioClient(Dio dio, ErrorMapper errorMapper) {
    return DioClient(dio: dio, errorMapper: errorMapper);
  }
}
