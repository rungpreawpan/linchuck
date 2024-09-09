import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CostPage extends StatelessWidget {
  const CostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          _summaryData(),
          const SizedBox(height: 20.0),
          _costList(),
        ],
      ),
    );
  }

  _summaryData() {
    return Container(
      width: 200.0,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Column(
        children: [
          TextFontStyle(
            'ค่าใช้จ่าย',
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFontStyle(
                '80000',
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              SizedBox(width: margin),
              TextFontStyle(
                'บาท',
                size: fontSizeM,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _costList() {
    return Expanded(
      child: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _costCard(
            title: 'แก้วพลาสติก',
            qty: 1,
            cost: 100.0,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: marginX2);
        },
      ),
    );
  }

  _costCard({
    required String title,
    required int qty,
    required double cost,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: marginX2,
        vertical: margin,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              TextFontStyle(
                title,
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                width: margin,
              ),
              TextFontStyle(
                'x $qty',
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
            ],
          ),
          TextFontStyle(
            '$cost บาท',
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
