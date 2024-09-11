import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/delete_dialog.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';
import 'package:lin_chuck/widget/count_button.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddEditProductDialog extends StatefulWidget {
  final bool isEdit;

  const AddEditProductDialog({
    super.key,
    this.isEdit = false,
  });

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final HomeController _homeController = Get.find();

  final TextEditingController _qtyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (!widget.isEdit) {
      _setNormalSweet();
    }
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
              const TextFontStyle(
                '“เพิ่ม/แก้ไข” สินค้า',
                color: Colors.black,
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 20.0),
              CounterButton(
                onDelete: () {
                  Get.dialog(const DeleteDialog());
                },
                onAdd: () {
                  //TODO: ควรจะต้องเช็คกับหลังบ้านว่ามีจำนวนเท่าไหร่
                },
                textEditingController: _qtyController,
              ),
              const SizedBox(height: 20.0),
              _options(),
              const SizedBox(height: 20.0),
              _actionButton(),
            ],
          ),
        ),
      ),
    );
  }

  _options() {
    return Column(
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
      ],
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
              Get.back(result: true);
              //TODO: send data
            },
            title: 'บันทึก',
            backgroundColor: primaryColor,
          ),
        )
      ],
    );
  }
}
