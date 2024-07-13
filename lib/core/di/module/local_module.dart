import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
@module
abstract class LocalModule {


  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();


  @preResolve
  Future<InternetConnection> checker() =>
      Future.value(InternetConnection.createInstance());

}
