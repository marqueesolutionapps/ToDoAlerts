// ignore_for_file: file_names

part of 'UtilityLibrary.dart';

class PermissionHandler {
  static Future<bool> determineNotification() async {
    var status = await Permission.notification.status;
    if (status == PermissionStatus.granted) {
      return true;
    }

    if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted) {
      status = await Permission.notification.request();
      if (status != PermissionStatus.granted) {
        return Future.error('Notification permission:  $status');
      }
    }
    return true;
  }

}