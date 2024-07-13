// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../../features/home/data/datasources/post_datasource.dart' as _i14;
import '../../features/home/data/datasources/post_datasource_impl.dart' as _i15;
import '../../features/home/data/datasources/post_local_datasource.dart' as _i9;
import '../../features/home/data/datasources/post_remote_datasource.dart'
    as _i12;
import '../../features/home/domain/repository/post_repository_impl.dart'
    as _i16;
import '../helper/shared_preference_helper.dart' as _i11;
import '../managers/graphql/graphql_client_agent.dart' as _i6;
import '../managers/localdb/hive_service.dart' as _i5;
import '../managers/navigation/app_navigator.dart' as _i8;
import '../managers/network/connection_checker.dart' as _i13;
import '../managers/network/dio_client.dart' as _i10;
import 'module/local_module.dart' as _i17;
import 'module/network_module.dart' as _i18;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.factoryAsync<_i3.SharedPreferences>(
    () => localModule.prefs(),
    preResolve: true,
  );
  await gh.factoryAsync<_i4.InternetConnection>(
    () => localModule.checker(),
    preResolve: true,
  );
  gh.factory<_i5.HiveService>(() => _i5.HiveService());
  gh.factory<_i6.GraphQlClientAgent>(() => _i6.GraphQlClientAgent());
  gh.lazySingleton<_i7.Dio>(() => networkModule.dio);
  gh.lazySingleton<_i8.AppNavigator>(() => _i8.AppNavigator());
  gh.lazySingleton<_i9.PostLocalDataSource>(() => _i9.PostLocalDataSource());
  gh.singleton<_i10.DioClient>(() => _i10.DioClient(gh<_i7.Dio>()));
  gh.lazySingleton<_i11.SharedPreferenceHelper>(
      () => _i11.SharedPreferenceHelper(gh<_i3.SharedPreferences>()));
  gh.lazySingleton<_i12.PostRemoteDataSource>(
      () => _i12.PostRemoteDataSource(gh<_i10.DioClient>()));
  gh.singleton<_i13.ConnectionChecker>(
      () => _i13.ConnectionCheckerImpl(gh<_i4.InternetConnection>()));
  gh.lazySingleton<_i14.PostDatasource>(() => _i15.PostDatasourceImpl(
        gh<_i9.PostLocalDataSource>(),
        gh<_i12.PostRemoteDataSource>(),
      ));
  gh.lazySingleton<_i16.PostRepositoryImpl>(
      () => _i16.PostRepositoryImpl(gh<_i14.PostDatasource>()));
  return getIt;
}

class _$LocalModule extends _i17.LocalModule {}

class _$NetworkModule extends _i18.NetworkModule {}
