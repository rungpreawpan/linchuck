import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/views/login/register_page.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateBackground(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(),
            _welcomeText(),
            const SizedBox(height: 30.0),
            _contactBox(),
            const SizedBox(height: 50.0),
            _loginPageButton(),
          ],
        ),
      ),
    );
  }

  _logo() {
    return Image.asset(
      'assets/icons/logo_white.png',
      width: 200.0,
      height: 200.0,
    );
  }

  _welcomeText() {
    return const Column(
      children: [
        TextFontStyle(
          'ขอต้อนรับสู่ "ลิ้นชัก"',
          color: Colors.white,
          weight: FontWeight.bold,
          size: 60.0,
        ),
        SizedBox(height: marginX2),
        TextFontStyle(
          'เราเป็นแอปพลิเคชั่นบริหารสินค้าและธุรกิจ',
          color: Colors.white,
          weight: FontWeight.bold,
          size: fontSizeXXL,
        ),
        TextFontStyle(
          'ที่จะมอบความสะดวกและราบรื่นในการบริหารธุรกิจของคุณ',
          color: Colors.white,
          weight: FontWeight.bold,
          size: fontSizeXXL,
        ),
      ],
    );
  }

  _contactBox() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFontStyle(
                'เพื่อเริ่มใช้งานสำหรับผู้บริหาร ',
                color: Colors.white,
                size: fontSizeXXL,
                weight: FontWeight.bold,
              ),
              TextFontStyle(
                'กรุณาติดต่อ 02-1234560 หรือ ',
                color: lYellow,
                size: fontSizeXXL,
                weight: FontWeight.bold,
              ),
              //TODO: edit icon
              Icon(
                Icons.phone,
                size: 35.0,
                color: lAmber,
              ),
            ],
          ),
          TextFontStyle(
            'โดยกดปุ่ม “ลงทะเบียน” เมื่อได้รับรหัสแล้ว',
            color: Colors.white,
            size: fontSizeXXL,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  _loginPageButton() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200.0),
          child: CustomSubmitButton(
            onTap: () {
              Get.to(() => const RegisterPage());
            },
            title: 'ลงทะเบียน',
            backgroundColor: lAmber,
          ),
        ),
        const SizedBox(height: marginX2),
        InkWell(
          onTap: () {
            Get.to(() => const LoginPage());
          },
          child: const TextFontStyle(
            'มีบัญชีอยู่แล้ว? เข้าสู่ระบบที่นี่',
            color: Colors.white,
            isUnderline: true,
          ),
        ),
      ],
    );
  }
}
