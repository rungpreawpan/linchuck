import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/login/controller/register_controller.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _registerController = RegisterController();

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _employeeCodeController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TemplateBackground(
          appBar: AppBar(
            backgroundColor: secondaryColor,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 250.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _logo(),
                const SizedBox(height: 20.0),
                _textField(),
                const SizedBox(height: 40.0),
                _registerButton(),
              ],
            ),
          ),
        ),
        _loading(),
      ],
    );
  }

  _logo() {
    return Image.asset(
      'assets/icons/logo_white.png',
      width: 180.0,
      height: 180.0,
    );
  }

  _textField() {
    return Column(
      children: [
        CustomTextField(
          textEditingController: _firstnameController,
          labelText: 'ชื่อ',
        ),
        const SizedBox(height: marginX2),
        CustomTextField(
          textEditingController: _lastnameController,
          labelText: 'นามสกุล',
        ),
        const SizedBox(height: marginX2),
        CustomTextField(
          textEditingController: _employeeCodeController,
          labelText: 'รหัสพนักงาน',
        ),
        const SizedBox(height: marginX2),
        CustomTextField(
          textEditingController: _emailController,
          labelText: 'อีเมล',
        ),
        const SizedBox(height: marginX2),
        CustomTextField(
          textEditingController: _passwordController,
          labelText: 'รหัสผ่าน',
          obscureText: _obscurePassword,
          suffix: InkWell(
            onTap: () {
              _obscurePassword = !_obscurePassword;
              setState(() {});
            },
            child: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  _registerButton() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 150.0),
          child: CustomSubmitButton(
            onTap: () async {
              await _registerController.verifyRegister(
                _firstnameController.text,
                _lastnameController.text,
                _emailController.text,
                _passwordController.text,
                _employeeCodeController.text,
              );
            },
            title: 'ลงทะเบียน',
            backgroundColor: lAmber,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextFontStyle(
              'หรือ',
              color: Colors.white,
            ),
            const SizedBox(width: 5.0),
            InkWell(
              onTap: () {
                Get.offAll(() => const LoginPage());
              },
              child: const TextFontStyle(
                'เข้าสู่ระบบ',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _registerController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
