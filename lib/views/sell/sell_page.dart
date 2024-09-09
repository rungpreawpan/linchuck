import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/sell/components/cost_page.dart';
import 'package:lin_chuck/views/sell/components/finance_page.dart';
import 'package:lin_chuck/views/sell/components/overview_page.dart';
import 'package:lin_chuck/views/sell/components/product_page.dart';
import 'package:lin_chuck/views/sell/components/sell_report_page.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/widget/main_template.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  int currentIndex = 0;

  List<String> categoryList = [
    'ภาพรวม',
    'รายงานยอดขาย',
    'การเงิน',
    'ค่าใช้จ่าย',
    'สินค้า',
  ];

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'ยอดขาย',
      contentWidget: [
        Expanded(
          child: Column(
            children: [
              _dataList(),
              const SizedBox(height: 20.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: _dataContent(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _dataList() {
    return SizedBox(
      height: 50.0,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          String item = categoryList[index];

           return CustomButton(
              onTap: () {
                currentIndex = index;
                setState(() {});
              },
              title: item,
             isSelected: currentIndex == index,
            );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginX2);
        },
      ),
    );
  }

  _dataContent() {
    if (currentIndex == 0) {
      return const OverviewPage();
    } else if (currentIndex == 1) {
      return const SellReportPage();
    } else if (currentIndex == 2) {
      return const FinancePage();
    } else if (currentIndex == 3) {
      return const CostPage();
    } else if (currentIndex == 4) {
      return const ProductPage();
    } else {
      return const SizedBox();
    }
  }
}
