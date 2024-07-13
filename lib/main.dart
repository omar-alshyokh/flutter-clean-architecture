import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:starter/core/di/di.dart';
import 'package:starter/core/managers/localdb/hive_service.dart';
import 'package:starter/features/app/presentation/pages/my_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await configureDependencies();

  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();




  await findDep<HiveService>().registerAdapters();

      {
    runApp(const MyApp());
  }
}

