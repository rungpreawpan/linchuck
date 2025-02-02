// import 'package:flutter/material.dart';
// import 'package:lin_chuck/constant/value_constant.dart';
// import 'package:lin_chuck/widget/text_font_style.dart';
//
// class CustomItemPickerCell extends StatelessWidget {
//   final Function() onTap;
//   final String title;
//   final bool isSelected;
//
//   const CustomItemPickerCell({
//     super.key,
//     required this.onTap,
//     required this.title,
//     this.isSelected = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: marginX2,
//           vertical: margin,
//         ),
//         decoration: BoxDecoration(
//           color: isSelected ? primaryColor : Colors.white,
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: customBoxShadow,
//         ),
//         child: TextFontStyle(
//           title,
//           size: fontSizeM,
//           color: isSelected ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomItemPickerCell extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CustomItemPickerCell({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        horizontal: marginX2,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: isSelected ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: customBoxShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFontStyle(
              title,
              size: fontSizeL,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          Visibility(
            visible: isSelected ? true : false,
            child: const Icon(
              Icons.check,
              size: 30.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}