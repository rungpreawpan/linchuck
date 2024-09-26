import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/controller/app_info_controller.dart';
import 'package:lin_chuck/views/category/category_page.dart';
import 'package:lin_chuck/views/employee/employee_page.dart';
import 'package:lin_chuck/views/home/home_page.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/views/receipt/receipt_page.dart';
import 'package:lin_chuck/views/sell/sell_page.dart';
import 'package:lin_chuck/views/stock/stock_page.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AppInfoController _appInfoController = Get.find();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  String? firstname;
  String? lastname;
  String? role;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    _appInfoController.getDeviceInfo();

    firstname = await storage.read(key: 'firstname');
    lastname = await storage.read(key: 'lastname');

    String? roleEng = await storage.read(key: 'role');
    if (roleEng == 'employee') {
      role = 'พนักงาน';
    } else {
      role = 'ผู้จัดการ';
    }

    setState(() {});
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 55.0,
        ),
        const SizedBox(height: marginX2),
        TextFontStyle(
          '$firstname $lastname',
          size: fontSizeXL,
          weight: FontWeight.bold,
          color: primaryColor,
        ),
        TextFontStyle(
          '$role',
          size: fontSizeM,
          color: primaryColor,
        ),
        Visibility(
          visible: role == 'ผู้จัดการ',
          child: const Divider(
            color: Colors.black,
            height: 20.0,
          ),
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
            onTap: () {
              Get.to(() => const HomePage());
            },
            title: 'รายการสินค้า',
          ),
          _navigateButton(
            onTap: () {
              Get.to(() => const SellPage());
            },
            title: 'ยอดขาย',
          ),
          _navigateButton(
            onTap: () {
              Get.to(() => const StockPage());
            },
            title: 'คลังสินค้า',
          ),
          _navigateButton(
            onTap: () {
              Get.to(() => const CategoryPage());
            },
            title: 'หมวดหมู่สินค้า',
          ),
          _navigateButton(
            onTap: () {
              Get.to(() => const ReceiptPage());
            },
            title: 'ใบเสร็จ',
          ),
          _navigateButton(
            onTap: () {
              Get.to(() => const EmployeePage());
            },
            title: 'พนักงาน',
          ),
        ],
      ),
    );
  }

  _navigateButton({
    required Function() onTap,
    required String title,
  }) {
    return Visibility(
      visible: role == 'ผู้จัดการ',
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFontStyle(
            title,
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
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
              const storage = FlutterSecureStorage();
              await storage.delete(key: 'login');
              await storage.delete(key: 'firstname');
              await storage.delete(key: 'lastname');
              await storage.delete(key: 'role');
              await storage.delete(key: 'image');

              Get.offAll(() => const LoginPage());
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
