import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showBackIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Visibility(
                  visible: showBackIcon,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                      const SizedBox(width: 30.0),
                    ],
                  ),
                ),
                TextFontStyle(
                  title,
                  size: 40.0,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            const Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
