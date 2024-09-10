import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/widget/custom_list_button.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class SelectCategoryDialog extends StatefulWidget {
  const SelectCategoryDialog({super.key});

  @override
  State<SelectCategoryDialog> createState() => _SelectCategoryDialogState();
}

class _SelectCategoryDialogState extends State<SelectCategoryDialog> {
  final HomeController _homeController = Get.find();

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _homeController.getProductType();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          contentPadding: const EdgeInsets.all(marginX2),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 80.0,
              minWidth: Get.width / 3,
              maxWidth: Get.width / 3,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextFontStyle(
                      'หมวดหมู่',
                      size: fontSizeL,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: marginX2),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: _homeController.productTypeList.length,
                      itemBuilder: (context, index) {
                        ProductTypeModel item = _homeController.productTypeList[index];
                        bool isSelected = _homeController.selectedProductTypeList.contains(item);

                        return CustomListButton(
                          onTap: () {
                            _homeController.selectedProductTypeList.clear();
                            _homeController.selectedProductTypeList.add(item);

                            setState(() {});
                          },
                          isSelected: isSelected,
                          title: item.name ?? '',
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: marginX2);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    _actionButton(),
                  ],
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _actionButton() {
    return Row(
      children: [
        Expanded(
          child: CustomSubmitButton(
            onTap: () {
              Get.back();
            },
            title: 'ยกเลิก',
            backgroundColor: Colors.transparent,
            showBorder: true,
            borderColor: primaryColor,
            fontColor: primaryColor,
          ),
        ),
        const SizedBox(width: marginX2),
        Expanded(
          child: CustomSubmitButton(
            onTap: () {
              Get.back();
            },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        )
      ],
    );
  }
}
