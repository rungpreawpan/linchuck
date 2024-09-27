import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/login/controller/forget_password_controller.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final ForgetPasswordController _forgetPasswordController = Get.find();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureNewPassword = true;

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
            padding: const EdgeInsets.symmetric(horizontal: 200.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _logo(),
                const SizedBox(height: 20.0),
                const TextFontStyle(
                  'รีเซ็ทรหัสผ่านใหม่',
                  size: 40.0,
                  color: Colors.white,
                  weight: FontWeight.bold,
                ),
                const SizedBox(height: 20.0),
                _textField(),
                const SizedBox(height: 40.0),
                _resetButton(),
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
          textEditingController: _newPasswordController,
          labelText: 'รหัสผ่านใหม่',
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
        const SizedBox(height: marginX2),
        CustomTextField(
          textEditingController: _confirmPasswordController,
          labelText: 'ยืนยันรหัสผ่านใหม่',
          obscureText: _obscureNewPassword,
          suffix: InkWell(
            onTap: () {
              _obscureNewPassword = !_obscureNewPassword;
              setState(() {});
            },
            child: Icon(
              _obscureNewPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  _resetButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 150.0),
      child: CustomSubmitButton(
        onTap: () async {
          await _forgetPasswordController.verifyPassword(
            _newPasswordController.text,
            _confirmPasswordController.text,
          );
        },
        title: 'รีเซ็ทรหัสผ่าน',
        backgroundColor: lAmber,
      ),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _forgetPasswordController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
