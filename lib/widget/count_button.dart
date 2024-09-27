import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CounterButton extends StatelessWidget {
  final int quantity;
  final Function() onDelete;
  final Function() onAdd;

  const CounterButton({
    super.key,
    required this.quantity,
    required this.onDelete,
    required this.onAdd,
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
          child: Center(
            child: TextFontStyle(
              quantity.toString(),
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
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
