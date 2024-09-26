import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';
import 'package:lin_chuck/views/receipt/controller/receipt_controller.dart';
import 'package:lin_chuck/views/receipt/model/order_detail_model.dart';
import 'package:lin_chuck/views/receipt/model/payment_model.dart';
import 'package:lin_chuck/widget/custom_dash_line.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ReceiptDetailPage extends StatefulWidget {
  final PaymentModel payment;
  final int receiptId;
  final int orderId;
  final int employeeId;

  const ReceiptDetailPage({
    super.key,
    required this.payment,
    required this.receiptId,
    required this.orderId,
    required this.employeeId,
  });

  @override
  State<ReceiptDetailPage> createState() => _ReceiptDetailPageState();
}

class _ReceiptDetailPageState extends State<ReceiptDetailPage> {
  final ReceiptController _receiptController = Get.find();
  final EmployeeController _employeeController = Get.find();
  final HomeController _homeController = Get.find();

  bool showPromptPayImage = false;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _receiptController.getOnePayment(widget.payment.paymentId ?? 0);
    await _receiptController.getOneReceipt(widget.receiptId);
    await _receiptController.getOneOrder(widget.orderId);
    await _receiptController.getOrderDetailById(widget.orderId);
    await _employeeController.getOneEmployee(widget.employeeId);
    await _homeController.getProduct();
    await _homeController.getSweet();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                !showPromptPayImage ? _receipt() : _promptPayImage(),
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
        ),
        _loading(),
      ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFontStyle(
                widget.payment.createOn != null
                    ? DateFormat('dd/MM/yyyy HH:mm')
                        .format(DateTime.parse(widget.payment.createOn!))
                    : '',
                size: fontSizeM,
              ),
              const TextFontStyle(
                'No. -', //TODO:
                size: fontSizeM,
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          const Center(
            child: TextFontStyle(
              'รายการสินค้า',
              size: 32.0,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24.0),
          const CustomDashLine(),
          const SizedBox(height: 24.0),
          _productList(),
          const SizedBox(height: 24.0),
          const CustomDashLine(),
          const SizedBox(height: marginX2),
          _employeeCard(
              '${_employeeController.selectedEmployee?.firstname} ${_employeeController.selectedEmployee?.lastname ?? ''}'),
          const SizedBox(height: marginX2),
          const CustomDashLine(),
          const SizedBox(height: marginX2),
          _paymentType(
            isPromptPay: _receiptController.payment?.payType == 'promtpay',
            total: _receiptController.payment?.totalPrice?.toDouble() ?? 0,
            cashReceive:
                _receiptController.payment?.cashReceive?.toDouble() ?? 0,
            cashReturn: _receiptController.payment?.cashReturn?.toDouble() ?? 0,
            promptPayImage: '',
          ),
          const SizedBox(height: marginX2),
          const CustomDashLine(),
          const SizedBox(height: 24.0),
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
                '${_receiptController.payment?.totalPrice?.toDouble() ?? 0} บาท',
                color: primaryColor,
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          const CustomDashLine(),
        ],
      ),
    );
  }

  _productList() {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: _receiptController.orderDetailByIdList.length,
        itemBuilder: (context, index) {
          OrderDetailModel item = _receiptController.orderDetailByIdList[index];
          int noOfOrder = index + 1;
          String productName = '';
          int cost = 0;
          int total = 0;
          String sweetLevel = '';

          for (ProductModel product in _homeController.productList) {
            if (product.id == item.productId) {
              productName = product.name ?? '';
              cost = product.productCost ?? 0;
              total = (item.quantity != null && product.productCost != null)
                  ? (item.quantity!) * (product.productCost!)
                  : 0;
            }
          }

          for (SweetModel sweet in _homeController.sweetList) {
            if (sweet.id == item.sweetId) {
              sweetLevel = '${sweet.name} (${sweet.percent}%)';
            }
          }

          return _productCard(
            index: noOfOrder,
            menu: productName,
            quantity: item.quantity ?? 0,
            cost: cost,
            total: total.toDouble(),
            isSweet: item.sweetId != null,
            sweetLevel: sweetLevel,
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
    required int cost,
    required double total,
    required bool isSweet,
    required String sweetLevel,
  }) {
    return Column(
      children: [
        Row(
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
            TextFontStyle(
              ' (${cost.toDouble()})',
              size: fontSizeM,
              color: Colors.grey.shade600,
            ),
            const Spacer(),
            TextFontStyle(
              '$total บาท',
              size: fontSizeM,
            ),
          ],
        ),
        Visibility(
          visible: isSweet,
          child: Row(
            children: [
              const SizedBox(width: marginX2),
              TextFontStyle(
                '- ระดับความหวาน: ',
                size: fontSizeS,
                color: Colors.grey.shade600,
              ),
              TextFontStyle(
                sweetLevel,
                size: fontSizeS,
                color: Colors.grey.shade600,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _employeeCard(String employeeName) {
    return Row(
      children: [
       const  TextFontStyle(
          'พนักงาน:',
          size: fontSizeM,
        ),
        const Spacer(),
        TextFontStyle(
          employeeName,
          size: fontSizeM,
        ),
      ],
    );
  }

  _paymentType({
    required bool isPromptPay,
    required double total,
    required double cashReceive,
    required double cashReturn,
    required String promptPayImage,
  }) {
    if (isPromptPay) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TextFontStyle(
                'เงินที่ได้รับ',
                size: fontSizeM,
              ),
              const Spacer(),
              TextFontStyle(
                '$total บาท',
                size: fontSizeM,
              ),
            ],
          ),
          Row(
            children: [
              const TextFontStyle(
                'หลักฐานการโอนเงิน',
                size: fontSizeM,
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  showPromptPayImage = !showPromptPayImage;

                  setState(() {});
                },
                child: const Icon(
                  Icons.photo_outlined,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TextFontStyle(
                'เงินที่ได้รับ',
                size: fontSizeM,
              ),
              const Spacer(),
              TextFontStyle(
                '$cashReceive บาท',
                size: fontSizeM,
              ),
            ],
          ),
          Row(
            children: [
              const TextFontStyle(
                'เงินทอน',
                size: fontSizeM,
              ),
              const Spacer(),
              TextFontStyle(
                '$cashReturn บาท',
                size: fontSizeM,
              ),
            ],
          ),
        ],
      );
    }
  }

  _promptPayImage() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.symmetric(
        horizontal: 150.0,
        vertical: 30.0,
      ),
      color: Colors.grey,
      height: Get.height,
      child: Stack(
        children: [
          //TODO: show promptpay image
          Positioned(
            top: margin,
            right: margin,
            child: InkWell(
              onTap: () {
                showPromptPayImage = !showPromptPayImage;

                setState(() {});
              },
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _receiptController.isLoading.value &&
            _homeController.isLoading.value &&
            _employeeController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
