import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Function(LongPressStartDetails)? onLongPress;
  final String title;
  final bool isSelected;

  const CustomButton({
    super.key,
    required this.onTap,
    this.onLongPress,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // onLongPress: onLongPress,
      onLongPressStart: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: TextFontStyle(
            title,
            size: fontSizeM,
            color: isSelected ? Colors.white : Colors.black,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
