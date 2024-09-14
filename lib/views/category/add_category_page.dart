import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddCategoryPage extends StatefulWidget {
  final bool isEdit;

  const AddCategoryPage({
    super.key,
    this.isEdit = false,
  });

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final HomeController _homeController = Get.find();

  final TextEditingController _productTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    if (widget.isEdit && _homeController.selectedProductTypeId != null) {
      String? name;

      for (ProductTypeModel type in _homeController.productTypeList) {
        if (type.id == _homeController.selectedProductTypeId) {
          name = type.name ?? '';
        }
      }

      _productTypeController.text = name ?? '-';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'เพิ่มหมวดหมู่สินค้า',
          contentWidget: [
            _content(),
          ],
        ),
        _loading(),
      ],
    );
  }

  _content() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFontStyle(
              widget.isEdit ? 'แก้ไขหมวดหมู่' : 'เพิ่มหมวดหมู่',
              color: Colors.black,
              size: fontSizeL,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 20.0),
            CustomTextField(
              textEditingController: _productTypeController,
              labelText: 'หมวดหมู่',
              helperText: 'เช่น อาหารจานเดี่ยว ขนม เครื่องดื่ม',
              maxLength: 30,
            ),
            const SizedBox(height: 100.0),
            _confirmAndCancelButton(),
          ],
        ),
      ),
    );
  }

  _confirmAndCancelButton() {
    return Row(
      children: [
        Expanded(
          child: CustomSubmitButton(
            onTap: () {
              Get.back();
            },
            title: 'ยกเลิก',
            fontColor: Colors.black,
            showBorder: true,
            borderColor: Colors.black,
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: CustomSubmitButton(
            onTap: widget.isEdit
                ? () async {
                    await _homeController.editProductType(
                      _homeController.selectedProductId ?? 0,
                      _productTypeController.text,
                    );
                  }
                : () async {
                    await _homeController
                        .addProductType(_productTypeController.text);
                  },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _homeController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
