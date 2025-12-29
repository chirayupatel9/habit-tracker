import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPermissionService {
  static const String _permissionAskedKey = 'notification_permission_asked';

  /// Check if permission has been asked before
  Future<bool> hasAskedPermission() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_permissionAskedKey) ?? false;
  }

  /// Mark that permission has been asked
  Future<void> markPermissionAsked() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_permissionAskedKey, true);
  }

  /// Check current notification permission status
  Future<NotificationPermissionStatus> checkPermission() async {
    final status = await Permission.notification.status;
    
    if (status.isGranted) {
      return NotificationPermissionStatus.granted;
    } else if (status.isDenied) {
      return NotificationPermissionStatus.denied;
    } else if (status.isPermanentlyDenied) {
      return NotificationPermissionStatus.permanentlyDenied;
    } else {
      return NotificationPermissionStatus.denied;
    }
  }

  /// Request notification permission
  Future<NotificationPermissionStatus> requestPermission() async {
    final status = await Permission.notification.request();
    await markPermissionAsked();
    
    if (status.isGranted) {
      return NotificationPermissionStatus.granted;
    } else if (status.isPermanentlyDenied) {
      return NotificationPermissionStatus.permanentlyDenied;
    } else {
      return NotificationPermissionStatus.denied;
    }
  }

  /// Open app settings
  Future<bool> openSettings() async {
    return await openAppSettings();
  }
}

enum NotificationPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
}

