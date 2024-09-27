import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/login/controller/login_controller.dart';
import 'package:lin_chuck/views/login/forget_password_page.dart';
import 'package:lin_chuck/views/login/register_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = Get.put(LoginController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal: 300.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo(),
                const SizedBox(height: 30.0),
                _textField(),
                const SizedBox(height: 20.0),
                _forgetButton(),
                const SizedBox(height: 40.0),
                _loginButton(),
                const SizedBox(height: marginX2),
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
      width: 200.0,
      height: 200.0,
    );
  }

  _textField() {
    return Column(
      children: [
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

  _forgetButton() {
    return InkWell(
      onTap: () {
        Get.to(() => const ForgetPasswordPage());
      },
      child: const TextFontStyle(
        'ลืมรหัสผ่าน',
        size: fontSizeL,
        color: Colors.white,
        isUnderline: true,
      ),
    );
  }

  _loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150.0),
      child: CustomSubmitButton(
        onTap: () async {
          await _loginController.verifyLogin(
            _emailController.text,
            _passwordController.text,
          );
        },
        title: 'เข้าสู่ระบบ',
        backgroundColor: lAmber,
      ),
    );
  }

  _registerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150.0),
      child: CustomSubmitButton(
        onTap: () {
          Get.to(() => const RegisterPage());
        },
        title: 'ลงทะเบียน',
        backgroundColor: lGreen,
      ),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _loginController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
