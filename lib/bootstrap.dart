import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app/app.dart';
import 'package:flutter_clean_architecture/app/config/app_config.dart';
import 'package:flutter_clean_architecture/app/config/environment.dart';
import 'package:flutter_clean_architecture/app/di/di.dart';

Future<void> bootstrap({required String flavor}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final env = EnvironmentX.from(flavor);
  final config = AppConfig.fromDefines(env: env);

  await configureDependencies(appConfig: config);

  runApp(const App());
}
