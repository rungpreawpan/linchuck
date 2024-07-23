import 'package:get/get.dart';
import 'package:lin_chuck/utils/access_permission.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoController extends GetxController {
  var appVersion = ''.obs;

  var cameraGranted = false.obs;
  var galleryGranted = false.obs;

  checkPermission() async {
    cameraGranted.value = await canAccessCamera();
    galleryGranted.value = await canAccessGallery();
  }

  getDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    appVersion('$version ($buildNumber)');
  }
}