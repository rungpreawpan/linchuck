import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class EditMenuDialog extends StatefulWidget {
  const EditMenuDialog({super.key});

  @override
  State<EditMenuDialog> createState() => _EditMenuDialogState();
}

class _EditMenuDialogState extends State<EditMenuDialog> {
  final HomeController _homeController = Get.find();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _homeController.getOptions();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.only(
        left: marginX2,
        right: marginX2,
        top: marginX2,
        bottom: margin,
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 80.0,
          minWidth: Get.width / 2,
          maxWidth: Get.width / 2,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFontStyle(
              'แก้ไข',
              color: Colors.black,
              size: fontSizeL,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // Get.bottomSheet();
                  },
                  child: Container(
                    height: 150.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    children: [
                      CustomTextField(
                        textEditingController: _productNameController,
                        labelText: 'ชื่อสินค้า',
                        maxLength: 30,
                      ),
                      const SizedBox(height: 4.0),
                      CustomTextField(
                        textEditingController: _priceController,
                        labelText: 'ราคา',
                      ),
                      const SizedBox(height: marginX2),
                      _selectedOptionBox(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _selectedOptionBox() {
    return _homeController.selectedOptionList.isEmpty
        ? InkWell(
            onTap: () {},
            child: Container(
              height: 50.0,
              width: Get.width,
              padding: const EdgeInsets.symmetric(
                horizontal: marginX2,
                vertical: margin,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const TextFontStyle(
                'ตัวเลือก',
                size: fontSizeM,
                color: Colors.grey,
              ),
            ),
          )
        : Column(
            children: [
              Row(
                children: [
                  const TextFontStyle(
                    'ตัวเลือก',
                    size: fontSizeM,
                  ),
                  const SizedBox(width: marginX2),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
