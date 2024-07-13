
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter/core/di/di.dart';
import 'package:starter/core/managers/navigation/app_navigator.dart';
import 'package:starter/core/utils/app_utils.dart';
import 'package:starter/features/auth/presentation/pages/login_page.dart';

import '../../constants/constants.dart';

@module
abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @lazySingleton
  Dio get dio {
    final dio = Dio();

    /// todo: fix this for github workflow

    dio
          // ..options.baseUrl = '${dotenv.env['BaseUrl2']}'
          ..options.baseUrl = Endpoints.baseUrl.value
          ..options.connectTimeout = EndpointsConfig.connectionTimeout
          ..options.receiveTimeout = EndpointsConfig.receiveTimeout
          ..options.headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
          ..interceptors.add(AuthInterceptor(dio))
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: (RequestOptions options,
                  RequestInterceptorHandler handler) async {
                return handler.next(options);
              },
            ),
          )
        // ..interceptors.add(PrettyDioLogger(
        //     requestHeader: true,
        //     requestBody: true,
        //     responseBody: true,
        //     responseHeader: false,
        //     error: true,
        //     logPrint: (o)=>debugPrint(o.toString()),
        //     compact: true,
        //     maxWidth: 250))
        ;

    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  final Dio _dio;

  bool isInvalidSession = false;

  // helper class to access your local storage

  AuthInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    appPrint('onRequest options.headers  ${options.headers}');
    isInvalidSession = false;
    return handler.next(options);
  }

  @override
  void onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    appPrint('onError in AuthInterceptor $error');
    appPrint('onError in AuthInterceptor isInvalidSession $isInvalidSession');
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 402 ||
        error.response?.statusCode == 403) {
     const loginRoute = LoginPage.routeName;
      bool isNewRouteSameAsCurrent = false;
      Navigator.popUntil(findDep<AppNavigator>().navigatorKey.currentContext!,
          (route) {
        if (route.settings.name == loginRoute) {
          isNewRouteSameAsCurrent = true;
        }
        return true;
      });

      appPrint("isNewRouteSameAsCurrent $isNewRouteSameAsCurrent");
      if (!isNewRouteSameAsCurrent) {
        Navigator.pushNamed(
          findDep<AppNavigator>().navigatorKey.currentContext!,

          /// todo: change it to login route name
          LoginPage.routeName,
        );
        isInvalidSession = true;
      }
    }
    handler.next(error);

    return;
  }
}
