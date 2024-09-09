import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/stock/add_stock_page.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'คลังสินค้าทั้งหมด',
      contentWidget: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _addStockButton(),
                ],
              ),
              const SizedBox(height: marginX2),
              _stockList(),
            ],
          ),
        ),
        const SizedBox(width: 30.0),
      ],
    );
  }

  _addStockButton() {
    return InkWell(
      onTap: () {
        Get.to(() => const AddStockPage());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: const Center(
          child: TextFontStyle(
            'เพิ่มสินค้า',
            color: Colors.white,
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _stockList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stockRow(
            isHeader: true,
            title1: 'ชื่อสินค้า',
            title2: 'ราคา',
            title3: 'วันที่สั่ง',
            title4: 'วันที่หมดอายุ',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              itemBuilder: (context, index) {
                return _stockRow(
                  title1: 'สินค้า01',
                  title2: '1000',
                  title3: '31/08/2024',
                  title4: '01/09/2024',
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  _stockRow({
    bool isHeader = false,
    required String title1,
    required String title2,
    required String title3,
    required String title4,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: !isHeader ? Container(
            height: 80.0,
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ) : null,
        ),
        const SizedBox(width: 30.0),
        Expanded(
          child: TextFontStyle(
            title1,
            size: isHeader ? fontSizeL : fontSizeM,
            weight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: TextFontStyle(
            title2,
            size: isHeader ? fontSizeL : fontSizeM,
            weight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Expanded(
          child: TextFontStyle(
            title3,
            size: isHeader ? fontSizeL : fontSizeM,
            weight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFontStyle(
                title4,
                size: isHeader ? fontSizeL : fontSizeM,
                weight: isHeader ? FontWeight.bold : FontWeight.normal,
              ),
            ],
          ),
        ),
        const SizedBox(width: 20.0),
        InkWell(
          onTap: !isHeader ? () {} : null,
          child: Icon(
            Icons.more_vert_rounded,
            size: fontSizeL,
            color: !isHeader ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }
}
