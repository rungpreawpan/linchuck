import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Function()? onOk;

  const CustomAlertDialog({
    super.key,
    required this.title,
    this.content,
    this.onOk,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.all(marginX2),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFontStyle(
              title,
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
            Visibility(
              visible: content != null,
              child: Column(
                children: [
                  const SizedBox(height: margin),
                  TextFontStyle(
                    content ?? '',
                    color: Colors.grey,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        CustomSubmitButton(
          onTap: () {
            Get.back(result: true);

            if (onOk != null) {
              onOk!();
            }
          },
          title: 'ตกลง',
          backgroundColor: primaryColor,
        ),
      ],
    );
  }
}
