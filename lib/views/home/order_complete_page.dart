import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/home_page.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextFontStyle(
                'ชำระเงินเรียบร้อย!',
                size: 40.0,
                weight: FontWeight.bold,
              ),
              const TextFontStyle(
                'กรุณาตรวจสอบใบเสร็จ',
                size: 40.0,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 80.0),
              _card(),
              const SizedBox(height: 32.0),
              _newOrderButton(),
            ],
          ),
        ),
      ),
    );
  }

  _card() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
          child: const Column(
            children: [
              SizedBox(height: 40.0),
              TextFontStyle(
                'ยอดรวม',
                size: 28.0,
                weight: FontWeight.bold,
              ),
              TextFontStyle(
                '2,178 บาท',
                size: 60.0,
                weight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFontStyle(
                    'เลขที่ใบเสร็จ',
                    size: fontSizeXL,
                  ),
                  TextFontStyle(
                    '345345',
                    size: fontSizeXL,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFontStyle(
                    'ช่องทางการขำระเงิน',
                    size: fontSizeXL,
                  ),
                  TextFontStyle(
                    'เงินสด',
                    size: fontSizeXL,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFontStyle(
                    'สถานะ',
                    size: fontSizeXL,
                  ),
                  TextFontStyle(
                    'สำเร็จ',
                    size: fontSizeXL,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFontStyle(
                    'วันที่',
                    size: fontSizeXL,
                  ),
                  TextFontStyle(
                    '08 สิงหาคม 2567 09:00น.',
                    size: fontSizeXL,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -80,
          width: Get.width - 400,
          child: const CircleAvatar(
            radius: 60.0,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 150.0,
            ),
          ),
        ),
      ],
    );
  }

  _newOrderButton() {
    return CustomSubmitButton(
      onTap: () {
        Get.off(() => const HomePage());
      },
      title: 'ทำรายการใหม่',
      buttonWidth: 300.0,
      backgroundColor: primaryColor,
    );
  }
}
