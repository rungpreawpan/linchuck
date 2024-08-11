import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomSubmitButton extends StatelessWidget {
  final Function() onTap;
  final double buttonHeight;
  final double? buttonWidth;
  final Color backgroundColor;
  final double borderRadius;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;

  const CustomSubmitButton({
    super.key,
    required this.onTap,
    this.buttonHeight = 50.0,
    this.buttonWidth,
    this.backgroundColor = Colors.grey,
    this.borderRadius = 25.0,
    this.showBorder = false,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
    required this.title,
    this.fontSize = fontSizeL,
    this.fontWeight = FontWeight.bold,
    this.fontColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: showBorder
              ? Border.all(
                  color: borderColor,
                  width: borderWidth,
                )
              : null,
        ),
        child: Center(
          child: TextFontStyle(
            title,
            size: fontSize,
            weight: fontWeight,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
