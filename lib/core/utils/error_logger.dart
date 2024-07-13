import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:starter/core/utils/app_utils.dart';


class ErrorLogger {
  static Future<void> logError(
    dynamic error,
    dynamic stack, {
    recordFirebase = true,
  }) async {
    if (recordFirebase) {
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/${false ? 'production' : 'development'}_errorLogs.txt');
    final timestamp = DateTime.now().toIso8601String();
    final errorContent =
        "[$timestamp] Error: $error\nStack Trace: $stack\n\n\n\n";
    appPrint(errorContent);
    await file.writeAsString(errorContent, mode: FileMode.append);
  }
}
