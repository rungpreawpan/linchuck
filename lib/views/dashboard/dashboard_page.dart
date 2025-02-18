import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/dashboard/components/cost_page.dart';
import 'package:lin_chuck/views/dashboard/components/finance_page.dart';
import 'package:lin_chuck/views/dashboard/components/overview_page.dart';
import 'package:lin_chuck/views/dashboard/components/product_page.dart';
import 'package:lin_chuck/views/dashboard/components/request_pdf_dialog.dart';
import 'package:lin_chuck/views/dashboard/components/sell_report_page.dart';
import 'package:lin_chuck/views/dashboard/controller/dashboard_controller.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/main_template.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _dashboardController.getAllData('${DateTime.now().year}-01-01 00:00:00',
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
          bottomPadding: 20.0,
          actionButton: _actionButton(),
          contentWidget: [
            Expanded(
              child: Column(
                children: [
                  _dataList(),
                  const SizedBox(height: marginX2),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(marginX2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: _dashboardController.dashboardData != null
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

  _actionButton() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Get.dialog(RequestPdfDialog());
          },
          child: Icon(Icons.file_present_outlined),
        ),
        const SizedBox(width: 20.0),
        InkWell(
          onTap: () {
            _prepareData();
          },
          child: const Icon(
            Icons.refresh,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  _dataContent() {
    if (currentIndex == 0) {
      return OverviewPage(dashboardData: _dashboardController.dashboardData!);
    } else if (currentIndex == 1) {
      return SellReportPage(dashboardData: _dashboardController.dashboardData!);
    } else if (currentIndex == 2) {
      return const FinancePage();
    } else if (currentIndex == 3) {
      return CostPage(sellData: _dashboardController.dashboardData!);
    } else if (currentIndex == 4) {
      return ProductPage(dashboardData: _dashboardController.dashboardData!);
    } else {
      return const SizedBox();
    }
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _dashboardController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
