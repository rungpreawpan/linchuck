import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/promotion/add_promotion_page.dart';
import 'package:lin_chuck/views/promotion/controller/promotion_controller.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/edit_delete_popup.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  final PromotionController _promotionController =
      Get.put(PromotionController());

  String selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'โปรโมชั่น',
          contentWidget: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _addPromotionButton(),
                    ],
                  ),
                  const SizedBox(height: marginX2),
                  _promotionList(),
                ],
              ),
            ),
          ],
        ),
        _loading(),
      ],
    );
  }

  _addPromotionButton() {
    return InkWell(
      onTap: () {
        Get.to(() => const AddPromotionPage());
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
            'เพิ่มโปรโมชั่น',
            color: Colors.white,
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _promotionList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _promotionRow(
            isHeader: true,
            title0: 'ชื่อโปรโมชั่น',
            title1: 'สินค้าโปรโมชั่น',
            title2: 'ราคาที่ลด',
            title3: 'ระยะเวลา',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _promotionRow(
                  title0: 'test $index',
                  title1: 'test',
                  title2: 'test',
                  title3: 'test',
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

  _promotionRow({
    bool isHeader = false,
    required String title0,
    required String title1,
    required String title2,
    required String title3,
  }) {
    return Padding(
      padding: isHeader
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextFontStyle(
              title0,
              size: isHeader ? fontSizeL : fontSizeM,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Expanded(
            flex: 2,
            child: TextFontStyle(
              title1,
              size: isHeader ? fontSizeL : fontSizeM,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
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
          const SizedBox(width: 20.0),
          isHeader
              ? const Icon(
                  Icons.more_vert_rounded,
                  size: fontSizeL,
                  color: Colors.white,
                )
              : EditDeletePopup(
                  selectedItem: selectedItem,
                  onEdit: () async {
                    // _employeeController.selectedEmployeeId = index;
                    //
                    // bool? result =
                    // await Get.to(() => const AddEmployeePage(isEdit: true));
                    //
                    // if (result != null) {
                    //   await _employeeController.getEmployee();
                    //
                    //   setState(() {});
                    // }
                  },
                  onDelete: () async {
                    // _employeeController.selectedEmployeeId = index;
                    // await _employeeController
                    //     .deleteEmployee(_employeeController.selectedEmployeeId ?? 0);
                    // Get.back();
                    //
                    // await _employeeController.getEmployee();
                    // Get.back();
                    // setState(() {});
                  },
                ),
        ],
      ),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _promotionController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
