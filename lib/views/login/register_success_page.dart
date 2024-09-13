import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateBackground(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 200.0,
          ),
          const SizedBox(height: 20.0),
          const TextFontStyle(
            'ลงทะเบียนเสร็จสิ้น!',
            size: 40.0,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
          const TextFontStyle(
            'คุณสามารถเริ่มใช้งาน "ลิ้นชัก" ได้ทันที',
            size: 35.0,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 450.0),
            child: CustomSubmitButton(
              onTap: () {
                Get.offAll(() => const LoginPage());
              },
              title: 'เข้าสู่หน้าหลัก',
              backgroundColor: lGreen,
            ),
          ),
        ],
      ),
    );
  }
}
