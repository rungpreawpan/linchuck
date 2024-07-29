import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.only(
        left: marginX2,
        right: marginX2,
        top: marginX2,
        bottom: margin,
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 80.0,
          minWidth: Get.width /3
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFontStyle(
              'เพิ่มหมวดหมู่',
              color: Colors.black,
              size: fontSizeL,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 20.0),
            CustomTextField(
              helperText: 'เช่น อาหารจานเดี่ยว ขนม เครื่องดื่ม',
              maxLength: 30,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CustomSubmitButton(
                onTap: () {
                  Get.back();
                },
                title: 'ยกเลิก',
                backgroundColor: Colors.transparent,
                showBorder: true,
                borderColor: primaryColor,
                fontColor: primaryColor,
              ),
            ),
            const SizedBox(width: marginX2),
            Expanded(
              child: CustomSubmitButton(
                onTap: () {
                  Get.back();
                },
                title: 'ยืนยัน',
                backgroundColor: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
