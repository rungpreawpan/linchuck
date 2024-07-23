import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/template_bg.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureNewPassword = true;

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
    );
  }

  _logo() {
    return Container(
      width: 100.0,
      height: 100.0,
      color: Colors.grey,
    );
  }

  _textField() {
    return Column(
      children: [
        CustomTextField(
          textEditingController: _passwordController,
          labelText: 'รหัสผ่านใหม่',
          obscureText: true,
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
          textEditingController: _newPasswordController,
          labelText: 'ยืนยันรหัสผ่านใหม่',
          obscureText: true,
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
        onTap: () {},
        title: 'รีเซ็ทรหัสผ่าน',
        backgroundColor: lAmber,
      ),
    );
  }
}
