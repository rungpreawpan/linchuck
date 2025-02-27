import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/receipt/controller/receipt_controller.dart';
import 'package:lin_chuck/views/receipt/model/order_detail_model.dart';
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
  final EmployeeController _employeeController = Get.find();

  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();

    _prepareDate();
  }

  _prepareDate() async {
    isLoading.value = true;
    await _receiptController.getReceipt();
    await _receiptController.getPayment();
    await _receiptController.getOrder();
    await _receiptController.getOrderDetail();
    await _employeeController.getEmployee();

    isLoading.value = false;
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
            child: const Icon(Icons.refresh_rounded),
          ),
        ),
        _loading(),
      ],
    );
  }

  _receiptList() {
    return Expanded(
      child: ListView.separated(
        itemCount: _receiptController.paymentList.reversed.length,
        itemBuilder: (context, index) {
          PaymentModel item =
              _receiptController.paymentList.reversed.toList()[index];
          int employeeId = 0;
          int orderId = 0;
          String receiptNo = '';

          for (ReceiptModel receipt in _receiptController.receiptList) {
            if (receipt.receiptId == item.receiptId) {
              employeeId = receipt.userId ?? 0;
              receiptNo = receipt.receiptNumber ?? '-';
            }
          }

          for (OrderModel order in _receiptController.orderList) {
            if (order.paymentId == item.paymentId) {
              orderId = order.orderId ?? 0;
            }
          }

          return _receiptCard(
            payment: item,
            receiptNo: receiptNo,
            createDate: item.createOn != null
                ? DateFormat('dd/MM/yyyy HH:mm')
                    .format(DateTime.parse(item.createOn!))
                : '-',
            total: _total(item).toString(),
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
  }) {
    return InkWell(
      onTap: () {
        Get.to(
          () => ReceiptDetailPage(
            payment: payment,
            orderId: orderId,
            receiptId: payment.receiptId ?? 0,
            receiptNo: receiptNo,
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

  _total(PaymentModel? item) {
    if (item?.payType == 'cash') {
      if (item?.totalPrice != null &&
          item?.cashReceive != null &&
          item?.cashReturn != null) {
        return (item!.cashReceive! - item!.cashReturn!).toDouble();
      } else {
        return 0;
      }
    } else {
      if (item?.totalPrice != null) {
        return item!.totalPrice!;
      } else {
        return 0;
      }
    }
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
