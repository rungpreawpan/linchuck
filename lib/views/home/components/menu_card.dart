import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/add_edit_product_dialog.dart';
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(3, 3), // Shadow position
                    ),
                  ],
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
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child:  Icon(
                      Icons.more_vert_rounded,
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
