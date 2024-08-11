import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';

class CounterButton extends StatelessWidget {
  final Function() onDelete;
  final Function() onAdd;
  final TextEditingController textEditingController;

  const CounterButton({
    super.key,
    required this.onDelete,
    required this.onAdd,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onDelete,
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
        SizedBox(
          width: 100.0,
          child: CustomTextField(
            textEditingController: textEditingController,
            inputType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 20.0),
        InkWell(
          onTap: onAdd,
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
}
