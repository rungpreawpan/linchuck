import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddIngredientDialog extends StatefulWidget {
  final int qty;

  const AddIngredientDialog({
    super.key,
    required this.qty,
  });

  @override
  State<AddIngredientDialog> createState() => _AddIngredientDialogState();
}

class _AddIngredientDialogState extends State<AddIngredientDialog> {
  final TextEditingController _qtyController = TextEditingController();

  int quantity = 1;

  @override
  void initState() {
    super.initState();

    quantity = widget.qty;
    _qtyController.text = quantity.toString();
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
                'เพิ่มวัตถุดิบ',
                color: Colors.black,
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 20.0),
              _counter(),
              const SizedBox(height: 20.0),
              _actionButton(),
            ],
          ),
        ),
      ),
    );
  }

  _counter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            if (quantity != 1) {
              quantity -= 1;
              _qtyController.text = quantity.toString();
              setState(() {});
            }
          },
          child: const CircleAvatar(
            radius: 15.0,
            backgroundColor: primaryColor,
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Container(
          width: 100.0,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: CustomTextField(
              textEditingController: _qtyController,
              inputType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                quantity = int.parse(value);
                setState(() {});
              },
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        InkWell(
          onTap: () {
            //TODO: ควรจะต้องเช็คกับหลังบ้านว่ามีจำนวนเท่าไหร่
            quantity += 1;
            _qtyController.text = quantity.toString();
            setState(() {});
          },
          child: const CircleAvatar(
            radius: 15.0,
            backgroundColor: primaryColor,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
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
              Get.back(result: quantity);
            },
            title: 'บันทึก',
            backgroundColor: primaryColor,
          ),
        )
      ],
    );
  }
}
