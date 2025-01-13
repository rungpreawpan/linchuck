import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/home_page.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class OrderCompletePage extends StatefulWidget {
  const OrderCompletePage({super.key});

  @override
  State<OrderCompletePage> createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage> {
  final HomeController _homeController = Get.find();

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
          child: Column(
            children: [
              const SizedBox(height: 40.0),
              const TextFontStyle(
                'ยอดรวม',
                size: 28.0,
                weight: FontWeight.bold,
              ),
              TextFontStyle(
                '${_homeController.orderDetailPayment?.totalPrice} บาท',
                size: 60.0,
                weight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFontStyle(
                    'เลขที่ใบเสร็จ',
                    size: fontSizeXL,
                  ),
                  TextFontStyle(
                    _homeController.receipt?.receiptNumber ?? '',
                    size: fontSizeXL,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFontStyle(
                    'ช่องทางการชำระเงิน',
                    size: fontSizeXL,
                  ),
                  TextFontStyle(
                    _homeController.orderDetailPayment?.payType == 'cash'
                        ? 'เงินสด'
                        : 'Promptpay',
                    size: fontSizeXL,
                  ),
                ],
              ),
              const Row(
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
                  const TextFontStyle(
                    'วันที่',
                    size: fontSizeXL,
                  ),
                  TextFontStyle(
                    DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(
                        _homeController.createOrderPayment?.createOn ??
                            DateTime.now().toString())),
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
        _homeController.receivedMoney = null;
        _homeController.changeMoney = null;
        _homeController.orderDetailPayment = null;
        _homeController.orderDetailList.clear();

        Get.off(() => const HomePage());
      },
      title: 'ทำรายการใหม่',
      buttonWidth: 300.0,
      backgroundColor: primaryColor,
    );
  }
}
