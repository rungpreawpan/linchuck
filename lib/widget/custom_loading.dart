import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black12,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
               CircularProgressIndicator(color: primaryColor),
               SizedBox(height: marginX2),
              TextFontStyle(
                'กำลังโหลด',
                color: Colors.black,
                weight: FontWeight.bold,
                size: fontSizeM,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
