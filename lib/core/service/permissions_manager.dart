import 'dart:io' as IO;



import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:starter/core/di/di.dart';
import 'package:starter/core/helper/shared_preference_helper.dart';
import 'package:starter/core/utils/app_utils.dart';

import '../constants/constants.dart';

class PermissionsManager {
  PermissionsManager._private();

  static final instance = PermissionsManager._private();

  final _notificationPermission = Permission.notification;
  final _locationAlwaysPermission = Permission.locationAlways;
  final _cameraPermission = Permission.camera;
  final _pref = findDep<SharedPreferenceHelper>();

  Future<List<Permission>> get _bluetoothPermission async {
    final sdkInt = IO.Platform.isAndroid
        ? (await DeviceInfoPlugin().androidInfo).version.sdkInt
        : -1;

    final androidPermissions = sdkInt > 30
        ? [Permission.bluetoothScan, Permission.bluetoothConnect]
        : [Permission.locationWhenInUse];
    final iOSPermissions = [Permission.bluetooth];

    return IO.Platform.isAndroid ? androidPermissions : iOSPermissions;
  }


  Future<void> initialize() async {}

  Future<bool> get isBluetoothPermissionGranted async {
    final bluetoothPermissions = await _bluetoothPermission;
    bool isAllGranted = true;
    for (final p in bluetoothPermissions) {
      final isGranted = await p.isGranted;
      if (!isGranted) {
        isAllGranted = false;
        break;
      }
    }
    return isAllGranted;
  }

  Future<bool> get isNotificationPermissionGranted {
    return _notificationPermission.isGranted;
  }


  Future<bool> get isCameraPermissionGranted {
    return _cameraPermission.isGranted;
  }

  Future<bool> get isLocationPermissionGranted {
    return _locationAlwaysPermission.isGranted;
  }

  Future<bool> requestBluetoothPermission() async {
    final permissions = await _bluetoothPermission;
    final statuses = await permissions.request();
    // final prefs = await SharedPreferences.getInstance();
    await _pref.saveBoolValue(AppStrings.bluetoothStorageKey, true);
    bool isAllGranted = true;
    for (final status in statuses.entries) {
      final isGranted = status.value == PermissionStatus.granted;
      if (!isGranted) {
        isAllGranted = false;
        break;
      }
    }
    return isAllGranted;
  }

  Future<bool> requestNotificationPermission() async {
    final status = await _notificationPermission.request();
    // final prefs = await SharedPreferences.getInstance();
    _pref.saveBoolValue(AppStrings.notificationStorageKey, true);
    return status == PermissionStatus.granted;
  }


  Future<bool> requestCameraPermission() async {
    final status = await _cameraPermission.request();
    return status == PermissionStatus.granted;
  }

  Future<bool> requestLocationPermission() async {
    final status = await _locationAlwaysPermission.request();
    _pref.saveBoolValue(AppStrings.locationStorageKey, true);
    return status == PermissionStatus.granted;
  }

  Future<bool> requestBluetoothPermissionIfNeeded() async {
    final isAlreadyGranted = await isBluetoothPermissionGranted;
    appPrint("isAlreadyGranted $isAlreadyGranted");
    if (isAlreadyGranted) {
      await _pref.saveBoolValue(AppStrings.bluetoothStorageKey, true);
      return true;
    } else {
      final didGrant = requestBluetoothPermission();
      return didGrant;
    }
  }

  Future<bool> requestNotificationPermissionIfNeeded() async {
    final isAlreadyGranted = await isNotificationPermissionGranted;
    if (isAlreadyGranted) {
      return true;
    } else {
      final didGrant = requestNotificationPermission();
      return didGrant;
    }
  }

  Future<bool> requestCameraPermissionIfNeeded() async {
    final isAlreadyGranted = await isCameraPermissionGranted;
    if (isAlreadyGranted) {
      return true;
    } else {
      final didGrant = requestCameraPermission();
      return didGrant;
    }
  }

  Future<bool> requestLocationPermissionIfNeeded() async {
    final isAlreadyGranted = await isLocationPermissionGranted;
    if (isAlreadyGranted) {
      return true;
    } else {
      final didGrant = requestLocationPermission();
      return didGrant;
    }
  }

  Future<void> openSystemSettings() async {
    bool hasOpenedAppSettings = await openAppSettings();
    appPrint('hasOpenedAppSettings: $hasOpenedAppSettings');
  }

  bool get didPreviouslyRequestBluetoothPermission {
    //final prefs = await SharedPreferences.getInstance();
    return _pref.getBool(AppStrings.bluetoothStorageKey) ?? false;
  }

  Future<bool> get didPreviouslyRequestNotificationPermission async {
    // final prefs = await SharedPreferences.getInstance();
    return _pref.getBool(AppStrings.notificationStorageKey) ?? false;
  }

  Future<bool> get didPreviouslyRequestLocationPermission async {
    // final prefs = await SharedPreferences.getInstance();
    return _pref.getBool(AppStrings.locationStorageKey) ?? false;
  }
}
