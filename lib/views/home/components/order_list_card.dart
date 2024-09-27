import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/add_edit_product_dialog.dart';
import 'package:lin_chuck/views/home/components/delete_dialog.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/order_complete_page.dart';
import 'package:lin_chuck/views/home/summary_order_page.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class OrderListCard extends StatefulWidget {
  final bool isSummaryPage;

  const OrderListCard({
    super.key,
    this.isSummaryPage = false,
  });

  @override
  State<OrderListCard> createState() => _OrderListCardState();
}

class _OrderListCardState extends State<OrderListCard> {
  final HomeController _homeController = Get.find();

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
            child: _homeController.selectedProductList.isNotEmpty
                ? ListView.separated(
                    itemCount: _homeController.selectedProductList.length,
                    itemBuilder: (context, index) {
                      ProductModel item =
                          _homeController.selectedProductList[index];

                      return _selectedProduct(
                        product: item.name ?? '',
                        quantity: item.quantity ?? 0,
                        price: double.parse(item.productPrice.toString()),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: marginX2);
                    },
                  )
                : const Center(
                    child: TextFontStyle(
                      'กรุณาเพิ่ม\nสินค้าที่ต้องการ',
                      size: fontSizeM,
                      weight: FontWeight.bold,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          _total(),
        ],
      ),
    );
  }

  _selectedProduct({
    required String product,
    required int quantity,
    required double price,
  }) {
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
        child: Row(
          children: [
            TextFontStyle(
              'x$quantity',
              size: fontSizeM,
              color: Colors.black,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFontStyle(
                product,
                size: fontSizeM,
                color: primaryColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10.0),
            TextFontStyle(
              price.toString(),
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
              'รวม',
              color: Colors.white,
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
            TextFontStyle(
              '2,178.-', //TODO
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
            onTap: widget.isSummaryPage
                ? () {
                    Get.to(() => const OrderCompletePage());
                  }
                : () {
                    Get.to(() => const SummaryOrderPage(total: 2178));
                  },
            title: widget.isSummaryPage ? 'บันทึกใบเสร็จ' : 'ชำระเงิน',
            backgroundColor: lYellow,
            fontColor: Colors.black,
          ),
        ),
      ],
    );
  }

  // _calTotal() {
  //   // for () {}
  // }
}
