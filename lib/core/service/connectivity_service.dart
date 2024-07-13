import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:starter/core/utils/app_utils.dart';

class ConnectivityService {
  // Static private instance of the class
  static final ConnectivityService _instance = ConnectivityService._internal();

  // Factory constructor to return the same instance
  factory ConnectivityService() {
    return _instance;
  }

  // Internal constructor
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();

  // Check WiFi connection
  Future<bool> isWifiConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    appPrint("connectivityResult: $connectivityResult");
    return connectivityResult.contains(ConnectivityResult.wifi);
  }

  // Check Mobile connection
  Future<bool> isMobileConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile);
  }

  // Check if there's any connection
  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  // Listen to connectivity changes
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  // Method to check general internet connectivity
  Future<bool> checkInternetAccess() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false; // Not connected to any network
    }

    try {
      // Ping Google's DNS to check for internet access
      final result = await InternetAddress.lookup('8.8.8.8');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false; // No internet access
    }
  }

  // Method to get the type of current connectivity (WiFi, Mobile, None)
  Future<List<ConnectivityResult>> getCurrentConnectivity() async {
    return await _connectivity.checkConnectivity();
  }

}
