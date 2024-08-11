import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomListButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isSelected;

  const CustomListButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: marginX2,
          vertical: margin,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: customBoxShadow,
        ),
        child: Row(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.white,
                border: Border.all(),
              ),
              child: Visibility(
                visible: isSelected,
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            TextFontStyle(
              title,
              size: fontSizeM,
            ),
          ],
        ),
      ),
    );
  }
}
