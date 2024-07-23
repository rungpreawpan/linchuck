import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/controller/app_info_controller.dart';
import 'package:lin_chuck/views/home/home_page.dart';
import 'package:lin_chuck/views/intro/controller/intro_controller.dart';
import 'package:lin_chuck/views/intro/intro_page.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final IntroController _introController = Get.put(IntroController());
  final AppInfoController _appInfoController = Get.put(AppInfoController());

  @override
  void initState() {
    super.initState();

    _redirect();
  }

  _redirect() async {
    await Future.delayed(const Duration(seconds: 2));

    const storage = FlutterSecureStorage();
    String? permission = await storage.read(key: 'permission');
    String? intro = await storage.read(key: 'intro');
    String? login = await storage.read(key: 'login');

    if (permission == null) {
      Get.off(() => const IntroPage());
    } else {
      if (intro == null) {
        _introController.currentPage(2);
        Get.off(() => const IntroPage());
      } else {
        if (login == null) {
          Get.off(() => const LoginPage());
        } else {
          Get.off(() => const HomePage());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateBackground(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              color: Colors.grey,
            ),
            const SizedBox(height: marginX2),
            _appVersion(),
          ],
        ),
      ),
    );
  }

  _appVersion() {
    return Obx(() {
      return TextFontStyle(
        'v ${_appInfoController.appVersion.value}',
        weight: FontWeight.bold,
      );
    });
  }
}
