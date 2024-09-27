import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/sell/components/cost_page.dart';
import 'package:lin_chuck/views/sell/components/finance_page.dart';
import 'package:lin_chuck/views/sell/components/overview_page.dart';
import 'package:lin_chuck/views/sell/components/product_page.dart';
import 'package:lin_chuck/views/sell/components/sell_report_page.dart';
import 'package:lin_chuck/views/sell/controller/sell_controller.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/main_template.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final SellController _sellController = Get.put(SellController());

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _sellController.getAllData('2024-01-01 00:00:00',
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));

    setState(() {});
  }

  int currentIndex = 0;
  String selectedMonth = '';

  List<String> categoryList = [
    'ภาพรวม',
    'รายการขาย',
    'กำไร/ขาดทุน',
    'ต้นทุน',
    'สินค้า',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'ยอดขาย',
          showActionButton: true,
          actionButton: _popUp(),
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
                      child: _sellController.sellData != null
                          ? _dataContent()
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _loading(),
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

  _popUp() {
    return InkWell(
      onTap: () {
        _prepareData();
      },
      child: const Icon(
        Icons.refresh,
        color: primaryColor,
      ),
    );
  }

  _dataContent() {
    if (currentIndex == 0) {
      return OverviewPage(sellData: _sellController.sellData!);
    } else if (currentIndex == 1) {
      return SellReportPage(sellData: _sellController.sellData!);
    } else if (currentIndex == 2) {
      return const FinancePage();
    } else if (currentIndex == 3) {
      return CostPage(sellData: _sellController.sellData!);
    } else if (currentIndex == 4) {
      return ProductPage(sellData: _sellController.sellData!);
    } else {
      return const SizedBox();
    }
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _sellController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
