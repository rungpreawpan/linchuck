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
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final IntroController _introController = Get.put(IntroController());
  final AppInfoController _appInfoController = Get.put(AppInfoController());

  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _checkFirstRun();
    _redirect();
  }

  _checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      await storage.deleteAll();

      prefs.setBool('first_run', false);
    }
  }

  _redirect() async {
    await _appInfoController.getDeviceInfo();
    await Future.delayed(const Duration(seconds: 2));

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
            Image.asset(
              'assets/icons/logo_white.png',
              width: 200.0,
              height: 200.0,
            ),
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
        size: fontSizeM,
        color: Colors.white,
        weight: FontWeight.bold,
      );
    });
  }
}
