import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/receipt/receipt_detail_page.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'ใบเสร็จ',
      contentWidget: [
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _receiptListCard();
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: marginX2);
            },
          ),
        ),
      ],
    );
  }

  _receiptListCard() {
    return InkWell(
      onTap: () {
        Get.to(
          () => const ReceiptDetailPage(
            date: '22.02.2022 - 12.00',
            receiptNo: '123456',
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: customBoxShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 20.0,
              height: 80.0,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
            ),
            const Expanded(
              child: Row(
                children: [
                  SizedBox(width: 20.0),
                  Icon(
                    Icons.receipt_long_rounded,
                    size: 50.0,
                  ),
                  SizedBox(width: 30.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFontStyle(
                          'รหัสใบเสร็จ 123456',
                          size: fontSizeM,
                          weight: FontWeight.bold,
                        ),
                        TextFontStyle(
                          '2000 บาท',
                          color: primaryColor,
                          size: fontSizeM,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  TextFontStyle(
                    '12:00',
                    size: fontSizeM,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
