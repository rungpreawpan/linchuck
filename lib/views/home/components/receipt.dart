import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/add_edit_product_dialog.dart';
import 'package:lin_chuck/views/home/components/delete_dialog.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 3.5,
      padding: const EdgeInsets.all(marginX2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            darkReceipt,
            lightReceipt,
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 2,
              itemBuilder: (context, index) {
                return _selectedProduct();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: marginX2);
              },
            ),
          ),
          _total(),
        ],
      ),
    );
  }

  _selectedProduct() {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Get.dialog(const AddEditProductDialog());
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (context) {
              Get.dialog(const DeleteDialog());
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(marginX2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Row(
          children: [
            TextFontStyle(
              'x1',
              size: fontSizeM,
              color: Colors.black,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: TextFontStyle(
                'Cake ส้ม',
                size: fontSizeM,
                color: primaryColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 10.0),
            TextFontStyle(
              '180.-',
              size: fontSizeM,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  _total() {
    return Column(
      children: [
        const Divider(
          color: Colors.white,
          thickness: 2.0,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFontStyle(
              'ส่วนลด',
              color: Colors.white,
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
            TextFontStyle(
              '0.-',
              color: Colors.white,
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFontStyle(
              'รวม',
              color: Colors.white,
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
            TextFontStyle(
              '2,178.-',
              color: Colors.white,
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomSubmitButton(
            onTap: () {},
            title: 'ชำระเงิน',
            backgroundColor: lYellow,
            fontColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
