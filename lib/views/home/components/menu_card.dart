import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/add_edit_product_dialog.dart';
import 'package:lin_chuck/views/home/components/edit_menu_dialog.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class MenuCard extends StatelessWidget {
  final bool isEdit;
  final ProductModel product;

  const MenuCard({
    super.key,
    this.isEdit = false,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: filter product type to show sweet
        Get.dialog(
          AddEditProductDialog(isEdit: isEdit),
        );
      },
      child:
      // Stack(
      //   children: [
          Column(
            children: [
              //TODO: change to image.file
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/images/orange_cake.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: marginX2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFontStyle(
                    product.name ?? '',
                    size: 20.0,
                    color: primaryColor,
                    weight: FontWeight.bold,
                  ),
                  TextFontStyle(
                    '${product.productPrice.toString()}.-',
                    size: 20.0,
                    color: Colors.red,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ],
          ),
          // Positioned(
          //   top: margin,
          //   right: 4.0,
          //   child: _moreButton(),
          // ),
      //   ],
      // ),
    );
  }

  // _moreButton() {
  //   return Visibility(
  //     visible: showMoreButton,
  //     child: InkWell(
  //       onTap: () {
  //         Get.dialog(
  //           const EditMenuDialog(isEdit: true),
  //         );
  //       },
  //       child: Container(
  //         height: 30.0,
  //         width: 30.0,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Colors.grey,
  //               blurRadius: 10,
  //               offset: Offset(3, 3),
  //             ),
  //           ],
  //           borderRadius: BorderRadius.circular(15.0),
  //         ),
  //         child: const Center(
  //           child: Icon(
  //             Icons.more_vert_rounded,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
