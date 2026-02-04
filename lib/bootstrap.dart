import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/app/app.dart';
import 'package:flutter_clean_architecture/app/config/app_config.dart';
import 'package:flutter_clean_architecture/app/di/di.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromDefines();

  // Optional: debug prints
  if (kDebugMode) {
    debugPrint('ENV=${config.env.name}');
    debugPrint('Pinning=${config.enableCertificatePinning}');
    debugPrint('PinnedHosts=${config.spkiPinsByHost.keys.toList()}');
  }

  await configureDependencies(appConfig: config);

  runApp(const App());
}
