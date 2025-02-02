import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/promotion/controller/promotion_controller.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
import 'package:lin_chuck/widget/custom_item_picker_cell.dart';
import 'package:lin_chuck/widget/custom_item_picker_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_select_date.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddPromotionPage extends StatefulWidget {
  const AddPromotionPage({super.key});

  @override
  State<AddPromotionPage> createState() => _AddPromotionPageState();
}

class _AddPromotionPageState extends State<AddPromotionPage> {
  final PromotionController _promotionController = Get.find();
  final HomeController _homeController = Get.find();

  final TextEditingController _promotionNameController =
      TextEditingController();
  final TextEditingController _fixedPriceController = TextEditingController();
  final TextEditingController _percentagePriceController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  String selectedProduct = 'กดเพื่อเลือกสินค้า';

  bool isPercentage = false;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'เพิ่มโปรโมชั่น',
          contentWidget: [
            Expanded(
              child: Column(
                children: [
                  _content(),
                  _confirmAndCancelButton(),
                ],
              ),
            ),
          ],
        ),
        _loading(),
      ],
    );
  }

  _content() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 15.0),
              CustomTextField(
                textEditingController: _promotionNameController,
                labelText: 'ชื่อโปรโมชั่น',
              ),
              const SizedBox(height: marginX2),
              _selectProduct(),
              //TODO: ถ้าเลือกเป็นpercentให้แสดงด้วยว่าลดกี่บาท
              const Divider(
                color: Colors.grey,
                height: 30.0,
              ),
              const TextFontStyle(
                'ส่วนลด',
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: marginX2),
              _priceDownData(
                isSelected: !isPercentage,
                title: 'ลดเป็นจำนวนเงิน',
                controller: _fixedPriceController,
                unit: '฿',
              ),
              const SizedBox(height: marginX2),
              _priceDownData(
                isSelected: isPercentage,
                title: 'ลดเป็นเปอร์เซ็นต์',
                controller: _percentagePriceController,
                unit: '%',
              ),
              const Divider(
                color: Colors.grey,
                height: 30.0,
              ),
              const TextFontStyle(
                'วันที่แสดงโปรโมชั่น',
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: marginX2),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        _startDate = await datePicker(context);

                        if (_startDate != null) {
                          _startDateController.text =
                              DateFormat('dd/MM/yyyy').format(_startDate!);

                          setState(() {});
                        }
                      },
                      child: CustomTextField(
                        isEnabled: false,
                        textEditingController: _startDateController,
                        labelText: 'วันที่เริ่ม',
                        suffix: const Icon(Icons.calendar_month_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(width: marginX2),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        _endDate = await datePicker(context);

                        if (_endDate != null) {
                          _endDateController.text =
                              DateFormat('dd/MM/yyyy').format(_endDate!);

                          setState(() {});
                        }
                      },
                      child: CustomTextField(
                        isEnabled: false,
                        textEditingController: _endDateController,
                        labelText: 'วันที่สิ้นสุด',
                        suffix: const Icon(Icons.calendar_month_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectProduct() {
    return InkWell(
      onTap: () async {
        List? result = await Get.to(
          () => CustomItemPicker(
            title: 'เลือกสินค้า',
            items: _homeController.productList,
            selectedItems: _homeController.selectedProductList,
            itemWidget: (item, isSelected) {
              ProductModel castedItem = item as ProductModel;

              return CustomItemPickerCell(
                title: castedItem.name ?? '-',
                isSelected: isSelected,
              );
            },
            onSearch: (searchText) {
              if (searchText != '') {
                return _homeController.productList
                    .where((product) => product.name!
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    .toList();
              } else {
                return _homeController.productList;
              }
            },
            hintText: 'ค้นหาสินค้า',
            pickMultipleItem: false,
          ),
        );

        if (result != null) {
          selectedProduct =
              _homeController.selectedProductList.first.name ?? '';
          setState(() {});
        }
      },
      child: Container(
        height: 80.0,
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: margin),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Visibility(
              visible: selectedProduct != 'กดเพื่อเลือกสินค้า',
              child: Row(
                children: [
                  Container(
                    height: 60.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
            ),
            TextFontStyle(
              selectedProduct,
              size: fontSizeL,
            ),
            const Spacer(),
            const Icon(
              Icons.navigate_next_rounded,
              size: 40.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  _priceDownData({
    required bool isSelected,
    required String title,
    required TextEditingController controller,
    required String unit,
  }) {
    return Row(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                if (isPercentage) {
                  _percentagePriceController.clear();
                } else {
                  _fixedPriceController.clear();
                }

                isPercentage = !isPercentage;
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 16.0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  radius: 15.0,
                  child: CircleAvatar(
                    backgroundColor:
                        isSelected ? primaryColor : Colors.grey.shade300,
                    radius: 10.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            TextFontStyle(
              title,
              size: fontSizeL,
            ),
          ],
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: CustomTextField(
            isEnabled: isSelected,
            textEditingController: controller,
            hintText: '0',
            suffix: SizedBox(
              width: 50.0,
              child: Center(
                child: TextFontStyle(
                  unit,
                  size: fontSizeL,
                  color: Colors.grey,
                ),
              ),
            ),
            // suffix: TextFontStyle('test'),
          ),
        ),
      ],
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
            showBorder: true,
            borderColor: primaryColor,
            backgroundColor: Colors.transparent,
            fontColor: primaryColor,
          ),
        ),
        const SizedBox(width: marginX2),
        Expanded(
          child: CustomSubmitButton(
            onTap: () async {
              if (_promotionNameController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณากรอกชื่อโปรโมชั่น'),
                );
              } else if (_homeController.selectedProductList.isEmpty) {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณาเลือกสินค้า'),
                );
              } else if (!isPercentage && _fixedPriceController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณากรอกส่วนลด'),
                );
              } else if (isPercentage &&
                  _percentagePriceController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณากรอกส่วนลด'),
                );
              } else if (_startDateController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(
                      title: 'กรุณาเลือกวันเริ่มต้นโปรโมชั่น'),
                );
              } else if (_endDateController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(
                      title: 'กรุณาเลือกวันสิ้นสุดโปรโมชั่น'),
                );
              } else {
                double discountAmount = 0;

                if (isPercentage) {
                  discountAmount =
                      _homeController.selectedProductList.first.productPrice! *
                          int.parse(_percentagePriceController.text) /
                          100;
                } else {
                  discountAmount = double.parse(_fixedPriceController.text);
                }

                await _promotionController.createPromotion(
                  promotionName: _promotionNameController.text,
                  productId: _homeController.selectedProductList.first.id ?? 0,
                  discountAmount: int.parse(discountAmount.toStringAsFixed(0)),
                  startDate: _startDateController.text,
                  endDate: _endDateController.text,
                );
                _homeController.selectedProductList.clear();
              }
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
        visible: _promotionController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
