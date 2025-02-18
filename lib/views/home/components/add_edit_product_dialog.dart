import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/selected_product_model.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';
import 'package:lin_chuck/widget/count_button.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddEditProductDialog extends StatefulWidget {
  final bool isEdit;
  final bool showSweet;
  final ProductModel? product;
  final int qty;

  const AddEditProductDialog({
    super.key,
    this.isEdit = false,
    this.showSweet = false,
    this.product,
    required this.qty,
  });

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final HomeController _homeController = Get.find();

  int quantity = 1;

  @override
  void initState() {
    super.initState();

    quantity = widget.qty;
    if (!widget.isEdit) {
      _setNormalSweet();
    }

    setState(() {});
  }

  _setNormalSweet() async {
    SweetModel normalSweet = _homeController.sweetList[3];
    _homeController.selectedSweet = normalSweet;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.all(marginX2),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 80.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFontStyle(
                widget.isEdit ? 'แก้ไขสินค้า' : 'เพิ่มสินค้า',
                color: Colors.black,
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 20.0),
              CounterButton(
                quantity: quantity,
                onDelete: () {
                  if (quantity != 1) {
                    quantity -= 1;
                    setState(() {});
                  }
                },
                onAdd: () {
                  //TODO: ควรจะต้องเช็คกับหลังบ้านว่ามีจำนวนเท่าไหร่
                  quantity += 1;
                  setState(() {});
                },
              ),
              const SizedBox(height: 20.0),
              _sweetLevel(),
              _actionButton(),
            ],
          ),
        ),
      ),
    );
  }

  _sweetLevel() {
    return Visibility(
      visible: widget.showSweet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFontStyle(
            'ระดับความหวาน',
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: marginX2),
          SizedBox(
            height: 50.0,
            width: Get.width / 1.2,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _homeController.sweetList.length,
              itemBuilder: (context, index) {
                SweetModel item = _homeController.sweetList[index];

                return InkWell(
                  onTap: () {
                    _homeController.selectedSweet = item;
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: marginX2),
                    decoration: BoxDecoration(
                      color: item == _homeController.selectedSweet
                          ? primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25.0),
                      border: item == _homeController.selectedSweet
                          ? null
                          : Border.all(),
                    ),
                    child: Center(
                      child: TextFontStyle(
                        '${item.percent}% ${item.name}',
                        size: fontSizeM,
                        color: item == _homeController.selectedSweet
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: marginX2);
              },
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
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
            onTap: widget.isEdit
                ? () {
                    SelectedProductModel orderDetail = SelectedProductModel(
                      product: widget.product,
                      sweet: widget.showSweet
                          ? _homeController.selectedSweet
                          : null,
                      quantity: quantity,
                    );

                    Get.back(result: orderDetail);
                  }
                : () {
                    SelectedProductModel orderDetail = SelectedProductModel(
                      product: widget.product,
                      sweet: widget.showSweet
                          ? _homeController.selectedSweet
                          : null,
                      quantity: quantity,
                    );

                    Get.back(result: orderDetail);
                  },
            title: 'บันทึก',
            backgroundColor: primaryColor,
          ),
        )
      ],
    );
  }
}
