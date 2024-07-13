import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
@lazySingleton
class AppNavigator {
  AppNavigator();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

}
