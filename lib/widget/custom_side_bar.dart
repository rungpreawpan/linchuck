import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSideBar extends StatelessWidget {
  final Function() onTap;

  const CustomSideBar({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: 60.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: onTap,
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
