import 'package:flutter_clean_architecture/core/error/error_mapper.dart';
import 'package:flutter_clean_architecture/core/network/dio_error_mapper.dart';
import 'package:flutter_clean_architecture/core/storage/preferences_service.dart';
import 'package:flutter_clean_architecture/core/storage/secure_storage_service.dart';
import 'package:flutter_clean_architecture/core/utils/logger.dart';
import 'package:injectable/injectable.dart';

@module
abstract class CoreModule {
  @lazySingleton
  PreferencesService preferencesService() => PreferencesService();

  @lazySingleton
  SecureStorageService secureStorageService() => SecureStorageService();

  @lazySingleton
  AppLogger logger() => const AppLogger(tag: 'STARTER');

  @lazySingleton
  ErrorMapper errorMapper() => const DioErrorMapper();
}
