import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/login/reset_password.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TemplateBackground(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(),
            const SizedBox(height: 20.0),
            _text(),
            const SizedBox(height: 40.0),
            _emailTextField(),
            const SizedBox(height: 40.0),
            _resetPassword(),
          ],
        ),
      ),
    );
  }

  _logo() {
    return Container(
      color: Colors.grey,
      width: 100.0,
      height: 100.0,
    );
  }

  _text() {
    return const Column(
      children: [
        TextFontStyle(
          'ลืมรหัสผ่าน?',
          size: 40.0,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 10.0),
        TextFontStyle(
          'กรุณากรอกอีเมลของคุณ แล้วเราจะทำการส่งลิงค์รีเซ็ทรหัสผ่านในอีเมลนั้น',
          size: fontSizeL,
          color: Colors.white,
        ),
      ],
    );
  }

  _emailTextField() {
    return CustomTextField(
      textEditingController: _emailController,
      labelText: 'อีเมล',
    );
  }

  _resetPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200.0),
      child: CustomSubmitButton(
        onTap: () {
          Get.to(() => const ResetPassword());
        },
        title: 'รีเซ็ทรหัสผ่าน',
        backgroundColor: lAmber,
      ),
    );
  }
}
