// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_clean_architecture/app/di/modules/core_module.dart'
    as _i133;
import 'package:flutter_clean_architecture/app/di/modules/network_module.dart'
    as _i616;
import 'package:flutter_clean_architecture/core/error/error_mapper.dart'
    as _i981;
import 'package:flutter_clean_architecture/core/network/dio_client.dart'
    as _i889;
import 'package:flutter_clean_architecture/core/storage/preferences_service.dart'
    as _i995;
import 'package:flutter_clean_architecture/core/storage/secure_storage_service.dart'
    as _i67;
import 'package:flutter_clean_architecture/core/utils/logger.dart' as _i714;
import 'package:flutter_clean_architecture/features/posts/data/datasources/posts_remote_datasource.dart'
    as _i435;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final coreModule = _$CoreModule();
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i995.PreferencesService>(
      () => coreModule.preferencesService(),
    );
    gh.lazySingleton<_i67.SecureStorageService>(
      () => coreModule.secureStorageService(),
    );
    gh.lazySingleton<_i714.AppLogger>(() => coreModule.logger());
    gh.lazySingleton<_i981.ErrorMapper>(() => coreModule.errorMapper());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i889.DioClient>(
      () => networkModule.dioClient(gh<_i361.Dio>(), gh<_i981.ErrorMapper>()),
    );
    gh.lazySingleton<_i435.PostsRemoteDataSource>(
      () => _i435.PostsRemoteDataSourceImpl(gh<_i889.DioClient>()),
    );
    return this;
  }
}

class _$CoreModule extends _i133.CoreModule {}

class _$NetworkModule extends _i616.NetworkModule {}
