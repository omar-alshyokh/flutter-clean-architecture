// Package imports:
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class ConnectionChecker {
  Future<bool> hasConnection();
}

@Singleton(as: ConnectionChecker)
class ConnectionCheckerImpl extends ConnectionChecker {
  final InternetConnection checker;

  ConnectionCheckerImpl(this.checker);

  @override
  Future<bool> hasConnection() async {
    return await checker.hasInternetAccess;
  }
}
