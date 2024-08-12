import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/delete_dialog.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/options_model.dart';
import 'package:lin_chuck/widget/count_button.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddEditProductDialog extends StatefulWidget {
  const AddEditProductDialog({super.key});

  @override
  State<AddEditProductDialog> createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final HomeController _homeController = Get.find();

  final TextEditingController _qtyController = TextEditingController();

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
    return SizedBox(
      height: 100.0,
      width: Get.width / 1.5,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _homeController.optionList.length,
        itemBuilder: (context, index) {
          OptionsModel item = _homeController.optionList[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFontStyle(
                item.name ?? '',
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: margin),
              SizedBox(
                height: 50.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: item.optionsDataModel!.length,
                  itemBuilder: (context, index) {
                    OptionsDataModel itemOption = item.optionsDataModel![index];

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: marginX2),
                      decoration: BoxDecoration(
                        //TODO: แก้ให้เปลี่ยนสีได้
                        // color: primary,
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(),
                      ),
                      child: Center(
                        child: TextFontStyle(
                          itemOption.optionName ?? '',
                          size: fontSizeM,
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
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: marginX2);
        },
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
