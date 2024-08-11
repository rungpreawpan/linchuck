import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/add_edit_product_dialog.dart';
import 'package:lin_chuck/views/home/components/edit_menu_dialog.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(const AddEditProductDialog());
      },
      child: Column(
        children: [
          //TODO: change to image.file
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: customBoxShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/orange_cake.png'),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: margin,
                right: 4.0,
                child: InkWell(
                  onTap: () {
                    Get.dialog(const EditMenuDialog());
                  },
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(3, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.more_vert_rounded,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: marginX2),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFontStyle(
                'Cake ส้ม',
                size: 20.0,
                color: primaryColor,
              ),
              TextFontStyle(
                '180.-',
                size: 20.0,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
