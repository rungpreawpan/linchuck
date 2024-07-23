import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/views/login/register_success_page.dart';
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
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  bool _obscurePassword = true;

  final List<String> items = [
    'ผู้จัดการ',
    'พนักงาน',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return TemplateBackground(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 250.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logo(),
            const SizedBox(height: 20.0),
            _textField(),
            const SizedBox(height: 20.0),
            _selectPosition(),
            const SizedBox(height: 40.0),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  _logo() {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey,
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

  _selectPosition() {
    return Row(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const TextFontStyle(
              'กรุณาเลือกตำแหน่ง',
              size: fontSizeM,
            ),
            items: items
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 11.0,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            radius: 10.0,
                            backgroundColor: Colors.grey.shade200,
                            child: Center(
                              child: CircleAvatar(
                                radius: 6.0,
                                backgroundColor: item == selectedValue
                                    ? primaryColor
                                    : Colors.grey.shade200,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: marginX2),
                        TextFontStyle(
                          item,
                          size: fontSizeM,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              selectedValue = value;
              setState(() {});
            },
            buttonStyleData: ButtonStyleData(
              height: 50.0,
              width: 280.0,
              padding: const EdgeInsets.symmetric(horizontal: marginX2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.expand_circle_down_outlined),
              iconEnabledColor: Colors.grey,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300.0,
              width: 300.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              offset: const Offset(0, -10),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40.0,
              padding: EdgeInsets.symmetric(horizontal: marginX2),
            ),
          ),
        ),
        const SizedBox(width: marginX2),
        Expanded(
          child: CustomTextField(
            isEnabled: selectedValue != null ? true : false,
            textEditingController: _roleController,
            labelText: 'รหัสพนักงาน',
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
            onTap: () {
              Get.to(() => const RegisterSuccessPage());
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
                Get.to(() => const LoginPage());
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
}
