import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> canAccessCamera() async {
  await Permission.camera.request();
  PermissionStatus cameraPermission = await Permission.camera.status;

  if (cameraPermission == PermissionStatus.granted) {
    return true;
  }

  return false;
}

Future<bool> canAccessGallery() async {
  bool useStoragePermission = false;
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final androidVersion = androidInfo.version.sdkInt;

    if (androidVersion <= 32) {
      useStoragePermission = true;
      await Permission.storage.request();
    }
  }

  await Permission.photos.request();

  PermissionStatus galleryPermission;
  if (useStoragePermission) {
    galleryPermission = await Permission.storage.status;
  } else {
    galleryPermission = await Permission.photos.status;
  }

  if (galleryPermission == PermissionStatus.granted) {
    return true;
  }

  return false;
}
