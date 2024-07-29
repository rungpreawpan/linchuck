import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/controller/app_info_controller.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AppInfoController _appInfoController = Get.find();

  @override
  void initState() {
    super.initState();

    _appInfoController.getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 3,
      child: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: marginX2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                _content(),
                _footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 55.0,
        ),
        SizedBox(height: marginX2),
        TextFontStyle(
          'บุ๊คโกะ โคบาอาชิ',
          size: fontSizeXL,
          weight: FontWeight.bold,
          color: primaryColor,
        ),
        TextFontStyle(
          'ร้าน Cafe Meow Meow',
          size: fontSizeM,
          color: primaryColor,
        ),
        Divider(
          color: Colors.black,
          height: 20.0,
        ),
      ],
    );
  }

  _content() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _navigateButton(
            onTap: () {},
            title: 'ยอดขาย',
          ),
          _navigateButton(
            onTap: () {},
            title: 'ใบเสร็จ',
          ),
          _navigateButton(
            onTap: () {},
            title: 'พนักงาน',
          ),
          _navigateButton(
            onTap: () {},
            title: 'รายการสินค้า',
          ),
        ],
      ),
    );
  }

  _navigateButton({
    required Function() onTap,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFontStyle(
          title,
          size: fontSizeM,
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  _footer() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              Get.off(() => const LoginPage());

              const storage = FlutterSecureStorage();
              await storage.delete(key: 'login');
            },
            child: const Row(
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: Icon(Icons.logout_rounded),
                ),
                SizedBox(width: margin),
                TextFontStyle(
                  'ออกจากระบบ',
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
          TextFontStyle(
            'v ${_appInfoController.appVersion.value}',
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ],
      );
    });
  }
}
