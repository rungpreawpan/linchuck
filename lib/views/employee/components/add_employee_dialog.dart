import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';

class AddEmployeeDialog extends StatelessWidget {
  const AddEmployeeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.all(marginX2),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 80.0,
          minWidth: Get.width / 2,
          maxWidth: Get.width / 2,
        ),
        // child: ,
      ),
    );
  }
}
