import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/promotion/add_promotion_page.dart';
import 'package:lin_chuck/views/promotion/controller/promotion_controller.dart';
import 'package:lin_chuck/views/promotion/model/promotion_model.dart';
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
  final PromotionController _promotionController = Get.find();

  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _promotionController.getPromotion();

    setState(() {});
  }

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
          showActionButton: true,
          actionButton: InkWell(
            onTap: () async {
              await _prepareData();
            },
            child: const Icon(
              Icons.refresh_rounded,
              color: primaryColor,
            ),
          ),
        ),
        _loading(),
      ],
    );
  }

  _addPromotionButton() {
    return InkWell(
      onTap: () async {
        bool? result = await Get.to(() => const AddPromotionPage());

        if (result != null) {
          await _promotionController.getPromotion();

          setState(() {});
        }
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
            index: 0,
            title0: 'ชื่อโปรโมชั่น',
            title1: 'สินค้าโปรโมชั่น',
            title2: 'ราคาที่ลด',
            title3: 'ระยะเวลา',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: _promotionController.promotionList.length,
              itemBuilder: (context, index) {
                PromotionModel item = _promotionController.promotionList[index];
                String startDate = DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(item.startDate!));
                String endDate = DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(item.endDate!));

                return _promotionRow(
                  index: item.promotionId ?? 0,
                  title0: item.promotionName ?? '-',
                  title1: 'test todo',
                  //TODO
                  title2: item.promotionAmount != null
                      ? '${item.promotionAmount} บาท'
                      : '-',
                  title3: '$startDate - $endDate',
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
    required int index,
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
                  showEdit: false,
                  onEdit: () {},
                  onDelete: () async {
                    _promotionController.selectedPromotionId = index;
                    await _promotionController.deletePromotion(
                        _promotionController.selectedPromotionId ?? 0);
                    Get.back();

                    await _promotionController.getPromotion();
                    Get.back();
                    setState(() {});
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
