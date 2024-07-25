import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3,
      padding: const EdgeInsets.all(marginX2),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [],
      ),
    );
  }
}
