import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  final String tag;
  final bool enabled;

  const AppLogger({
    this.tag = 'APP',
    this.enabled = kDebugMode,
  });

  void log(String message, {LogLevel level = LogLevel.debug}) {
    if (!enabled) return;
    if(kDebugMode) {
      debugPrint('[$tag][${level.name.toUpperCase()}] $message');
    }
  }

  void debug(String message) => log(message);

  void info(String message) => log(message, level: LogLevel.info);

  void warning(String message) => log(message, level: LogLevel.warning);

  void error(String message) => log(message, level: LogLevel.error);
}
