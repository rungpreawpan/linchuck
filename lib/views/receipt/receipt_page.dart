import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/receipt/controller/receipt_controller.dart';
import 'package:lin_chuck/views/receipt/model/order_model.dart';
import 'package:lin_chuck/views/receipt/model/payment_model.dart';
import 'package:lin_chuck/views/receipt/model/receipt_model.dart';
import 'package:lin_chuck/views/receipt/receipt_detail_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final ReceiptController _receiptController = Get.put(ReceiptController());
  final EmployeeController _employeeController = Get.put(EmployeeController());

  @override
  void initState() {
    super.initState();

    _prepareDate();
  }

  _prepareDate() async {
    await _receiptController.getReceipt();
    await _receiptController.getPayment();
    await _receiptController.getOrder();
    await _receiptController.getOrderDetail();
    await _employeeController.getEmployee();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'ใบเสร็จ',
          contentWidget: [
            _receiptList(),
          ],
          showActionButton: true,
          actionButton: InkWell(
            onTap: () async {
              await _prepareDate();
            },
            child: const Icon(
              Icons.refresh_rounded,
              color: primaryColor,
            ),
          ),
        ),
        _loading(),
      ],
    );
  }

  _receiptList() {
    return Expanded(
      child: ListView.separated(
        itemCount: _receiptController.paymentList.length,
        itemBuilder: (context, index) {
          PaymentModel item = _receiptController.paymentList[index];
          int employeeId = 0;
          int orderId = 0;

          for (ReceiptModel receipt in _receiptController.receiptList) {
            if (receipt.receiptId == item.receiptId) {
              employeeId = receipt.userId ?? 0;
            }
          }

          for (OrderModel order in _receiptController.orderList) {
            if (order.paymentId == item.paymentId) {
              orderId = order.orderId ?? 0;
            }
          }

          return _receiptCard(
            payment: item,
            receiptNo: '-',
            createDate: item.createOn != null
                ? DateFormat('dd//MM/yyyy HH:mm')
                    .format(DateTime.parse(item.createOn!))
                : '-',
            total: item.totalPrice != null ? item.totalPrice.toString() : '0',
            employeeId: employeeId,
            orderId: orderId,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: marginX2);
        },
      ),
    );
  }

  _receiptCard({
    required String receiptNo,
    required String createDate,
    required String total,
    required PaymentModel payment,
    required int employeeId,
    required int orderId,
    // required ReceiptModel receipt,
  }) {
    return InkWell(
      onTap: () {
        Get.to(
          () => ReceiptDetailPage(
            // receipt: receipt,
            //TODO:
            payment: payment,
            // paymentId: payment.paymentId ?? 0,
            orderId: orderId,
            receiptId: payment.receiptId ?? 0,
            employeeId: employeeId,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: customBoxShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 20.0,
              height: 80.0,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 20.0),
                  const Icon(
                    Icons.receipt_long_rounded,
                    size: 50.0,
                  ),
                  const SizedBox(width: 30.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFontStyle(
                          'รหัสใบเสร็จ $receiptNo',
                          size: fontSizeM,
                          weight: FontWeight.bold,
                        ),
                        TextFontStyle(
                          '$total บาท',
                          color: primaryColor,
                          size: fontSizeM,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  TextFontStyle(
                    createDate,
                    size: fontSizeM,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _receiptController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
