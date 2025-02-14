import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/dashboard/controller/dashboard_controller.dart';
import 'package:lin_chuck/views/dashboard/model/dashboard_model.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CostPage extends StatefulWidget {
  final DashboardModel sellData;

  const CostPage({
    super.key,
    required this.sellData,
  });

  @override
  State<CostPage> createState() => _CostPageState();
}

class _CostPageState extends State<CostPage> {
  final DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: _dashboardController.dashboardData != null
          ? Column(
              children: [
                _summaryData(),
                const SizedBox(height: 20.0),
                _costList(),
              ],
            )
          : const Center(
              child: TextFontStyle(
                'ไม่พบข้อมูล',
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
            ),
    );
  }

  _summaryData() {
    return Container(
      width: 200.0,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          const TextFontStyle(
            'ต้นทุน',
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFontStyle(
                widget.sellData.allCosts.toString(),
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(width: margin),
              const TextFontStyle(
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
        itemCount: _dashboardController.dashboardData!.sellProduct!.length,
        itemBuilder: (context, index) {
          SellProductModel? item = _dashboardController.dashboardData!.sellProduct![index];

          return _costCard(
            title: item.name ?? '',
            qty: item.count ?? 0,
            cost: item.cost ?? 0,
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
        color: Colors.grey.shade200,
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
              const SizedBox(
                width: margin,
              ),
              TextFontStyle(
                '($cost)',
                size: fontSizeM,
                weight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ],
          ),
          TextFontStyle(
            '${cost*qty} บาท',
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
