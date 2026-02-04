import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/app/config/app_config.dart';

HttpClientAdapter buildPinnedAdapter(AppConfig config) {
  throw UnsupportedError(
    'Certificate pinning is not supported on Flutter Web (browser controls TLS).',
  );
}
