import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class DeleteDialog extends StatelessWidget {
  final Function()? onOk;

  const DeleteDialog({
    super.key,
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
            Image.asset(
              'assets/icons/delete.png',
              width: 120.0,
            ),
            const SizedBox(height: marginX2),
            const TextFontStyle(
              'ต้องการลบรายการนี้หรือไม่',
              size: fontSizeM,
            ),
            const SizedBox(height: marginX2),
            _actionButton(),
          ],
        ),
      ),
    );
  }

  _actionButton() {
    return Row(
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

              //TODO:
              if (onOk != null) {
                onOk!();
              }
            },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        )
      ],
    );
  }
}
