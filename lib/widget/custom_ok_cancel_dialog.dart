import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomOkCancelDialog extends StatelessWidget {
  final Widget? icon;
  final String title;
  final Color? titleColor;
  final Widget? content;
  final Function()? onOK;
  final String? okText;
  final Color? okColor;
  final bool showCancel;
  final Function()? onCancel;
  final String? cancelText;

  const CustomOkCancelDialog({
    super.key,
    this.icon,
    required this.title,
    this.titleColor,
    this.content,
    this.onOK,
    this.okText,
    this.okColor,
    this.showCancel = true,
    this.onCancel,
    this.cancelText,
  });

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
        constraints: const BoxConstraints(minHeight: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Column(
                    children: [
                      icon!,
                      const SizedBox(height: margin),
                    ],
                  )
                : const SizedBox(),
            TextFontStyle(
              title,
              color: titleColor ?? Colors.black,
              size: fontSizeL,
              weight: FontWeight.bold,
            ),
            Visibility(
              visible: content != null,
              child: content!,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showCancel
                ? Expanded(
                    child: CustomSubmitButton(
                      onTap: () {
                        Get.back();

                        if (onCancel != null) {
                          onCancel!();
                        }
                      },
                      title: cancelText ?? 'ยกเลิก',
                      borderRadius: 22.5,
                      showBorder: true,
                      borderColor: primaryColor,
                      borderWidth: 1.5,
                      fontColor: primaryColor,
                      backgroundColor: Colors.transparent,
                      buttonHeight: 45.0,
                    ),
                  )
                : Container(),
            showCancel ? const SizedBox(width: margin) : const SizedBox(),
            Expanded(
              child: CustomSubmitButton(
                onTap: () {
                  Get.back(result: true);

                  if (onOK != null) {
                    onOK!();
                  }
                },
                title: okText ?? 'ยืนยัน',
                borderRadius: 22.5,
                buttonHeight: 45.0,
                backgroundColor: okColor ?? primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
