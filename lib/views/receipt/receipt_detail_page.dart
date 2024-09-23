import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/receipt/controller/receipt_controller.dart';
import 'package:lin_chuck/views/receipt/model/receipt_model.dart';
import 'package:lin_chuck/widget/custom_dash_line.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ReceiptDetailPage extends StatefulWidget {
  final ReceiptModel receipt;

  const ReceiptDetailPage({
    super.key,
    required this.receipt,
  });

  @override
  State<ReceiptDetailPage> createState() => _ReceiptDetailPageState();
}

class _ReceiptDetailPageState extends State<ReceiptDetailPage> {
  final ReceiptController _receiptController = Get.find();
  final EmployeeController _employeeController = Get.find();

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    print(widget.receipt.receiptId);
    await _receiptController.getOneOrder(widget.receipt.receiptId ?? 0);
    await _receiptController.getOnePayment(widget.receipt.receiptId ?? 0);
    // await _receiptController.getOrderDetailById(widget.receipt.receiptId ?? 0);
    // await _employeeController.getOneEmployee(widget.receipt.userId ?? 0);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _receipt(),
            Positioned(
              top: 30.0,
              left: 30.0,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _receipt() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 150.0,
        vertical: 30.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFontStyle(
                widget.receipt.createOn != null
                    ? DateFormat('dd/MM/yyyy HH:mm')
                        .format(DateTime.parse(widget.receipt.createOn!))
                    : '',
                size: fontSizeM,
              ),
              const TextFontStyle(
                'No. ',
                size: fontSizeM,
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          const TextFontStyle(
            'รายการสินค้า',
            size: 32.0,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 30.0),
          const CustomDashLine(),
          const SizedBox(height: 30.0),
          _productList(),
          const SizedBox(height: 30.0),
          const CustomDashLine(),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextFontStyle(
                'ยอดรวมทั้งหมด',
                color: primaryColor,
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
              TextFontStyle(
                '${_receiptController.payment?.totalPrice ?? 0} บาท',
                color: primaryColor,
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          const CustomDashLine(),
        ],
      ),
    );
  }

  _productList() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          int productIndex = index + 1;

          return _productCard(
            index: productIndex,
            menu: 'cake',
            quantity: 1,
            total: 180.0,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: margin);
        },
      ),
    );
  }

  _productCard({
    required int index,
    required String menu,
    required int quantity,
    required double total,
  }) {
    return Row(
      children: [
        TextFontStyle(
          '$index. ',
          size: fontSizeM,
        ),
        TextFontStyle(
          menu,
          size: fontSizeM,
        ),
         TextFontStyle(
          ' x$quantity',
          size: fontSizeM,
        ),
        const Spacer(),
        TextFontStyle(
          '$total บาท',
          size: fontSizeM,
        ),
      ],
    );
  }
}
