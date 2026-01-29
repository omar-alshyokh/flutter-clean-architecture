import 'package:flutter_clean_architecture/app/config/app_config.dart';
import 'package:flutter_clean_architecture/app/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({
  required AppConfig appConfig,
}) async {
  if (!getIt.isRegistered<AppConfig>()) {
    getIt.registerSingleton<AppConfig>(appConfig);
  }
  getIt.init();
}
