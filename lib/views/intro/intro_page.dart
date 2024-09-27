import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/controller/app_info_controller.dart';
import 'package:lin_chuck/views/intro/controller/intro_controller.dart';
import 'package:lin_chuck/views/intro/welcome_page.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final IntroController _introController = Get.find();
  final AppInfoController _appInfoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TemplateBackground(
      body: _content(),
    );
  }

  _content() {
    return Obx(() {
      switch (_introController.currentPage.value) {
        case 0:
          return _template(
              imagePath: 'camera.png',
              description1: 'แอปพลิเคชั่นต้องการเข้าถึงกล้องถ่ายรูป',
              description2: 'เพื่อถ่ายรูปสินค้าและเอกสารประกอบการส่งสินค้า',
              next: _cameraPermission,
              back: () {});
        case 1:
          return _template(
              imagePath: 'gallery.png',
              description1: 'แอปพลิเคชั่นต้องการเข้าถึงคลังรูปภาพ',
              description2: 'เพื่อเพิ่มการใช้งานรูปภาพจากในคลัง',
              next: _galleryPermission,
              back: () {
                _introController.currentPage(0);
              });

        case 2:
          return const WelcomePage();

        default:
          return Container();
      }
    });
  }

  _template({
    required String imagePath,
    required String description1,
    required String description2,
    required Function() next,
    required Function() back,
  }) {
    return Center(
      child: Container(
        width: Get.width / 1.5,
        height: Get.height / 1.5,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/$imagePath',
              width: 200.0,
            ),
            const SizedBox(height: 40.0),
            TextFontStyle(
              description1,
              size: 30.0,
            ),
            TextFontStyle(
              description2,
              size: 30.0,
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: _introController.currentPage.value == 1,
                  child: Row(
                    children: [
                      CustomSubmitButton(
                        onTap: back,
                        title: 'ย้อนกลับ',
                        buttonWidth: 300.0,
                        showBorder: true,
                        borderWidth: 2.0,
                        borderColor: secondaryColor,
                        backgroundColor: Colors.transparent,
                        fontColor: secondaryColor,
                      ),
                      const SizedBox(width: marginX2),
                    ],
                  ),
                ),
                CustomSubmitButton(
                  onTap: next,
                  title: 'ถัดไป',
                  buttonWidth: 300.0,
                  backgroundColor: secondaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _cameraPermission() async {
    var result = await Permission.camera.request();

    if (result == PermissionStatus.granted) {
      _appInfoController.cameraGranted(true);
    } else {
      _appInfoController.cameraGranted(false);
    }

    _introController.currentPage(1);
  }

  _galleryPermission() async {
    bool useStoragePermission = false;
    const storage = FlutterSecureStorage();

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        useStoragePermission = true;
        await Permission.storage.request();
      }
    }

    await Permission.photos.request();

    PermissionStatus result;
    if (useStoragePermission) {
      result = await Permission.storage.status;
    } else {
      result = await Permission.photos.status;
    }

    if (result == PermissionStatus.granted) {
      _appInfoController.galleryGranted(true);
    } else {
      _appInfoController.galleryGranted(false);
    }

    _introController.currentPage(2);
    await storage.write(key: 'permission', value: 'true');
  }
}
