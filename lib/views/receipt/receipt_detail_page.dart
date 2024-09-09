import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_dash_line.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ReceiptDetailPage extends StatefulWidget {
  final String date;
  final String receiptNo;

  const ReceiptDetailPage({
    super.key,
    required this.date,
    required this.receiptNo,
  });

  @override
  State<ReceiptDetailPage> createState() => _ReceiptDetailPageState();
}

class _ReceiptDetailPageState extends State<ReceiptDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'ใบเสร็จ',
      showBackButton: true,
      contentWidget: [
        _receipt(),
      ],
    );
  }

  _receipt() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 150.0,
          vertical: 30.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFontStyle(
                  widget.date,
                  size: fontSizeM,
                ),
                TextFontStyle(
                  'No. ${widget.receiptNo}',
                  size: fontSizeM,
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            const TextFontStyle(
              'รายการสินค้า',
              size: 32.0,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 30.0),
            const CustomDashLine(),
            const SizedBox(height: 30.0),
            _productList(),
            const SizedBox(height: 30.0),
            const CustomDashLine(),
            const SizedBox(height: 30.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFontStyle(
                  'ยอดรวมทั้งหมด',
                  color: primaryColor,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
                TextFontStyle(
                  '2,178 บาท',
                  color: primaryColor,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            const CustomDashLine(),
          ],
        ),
      ),
    );
  }

  _productList() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          int productIndex = index + 1;

          return _productCard(
            index: productIndex,
            total: 180.0,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: margin);
        },
      ),
    );
  }

  _productCard({
    required int index,
    required double total,
  }) {
    return Row(
      children: [
        TextFontStyle(
          '$index. ',
          size: fontSizeM,
        ),
        const TextFontStyle(
          'cake ส้ม',
          size: fontSizeM,
        ),
        const TextFontStyle(
          'x1',
          size: fontSizeM,
        ),
        const Spacer(),
        TextFontStyle(
          '$total บาท',
          size: fontSizeM,
        ),
      ],
    );
  }
}
