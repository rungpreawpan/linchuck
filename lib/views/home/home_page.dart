import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/category/category_page.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/home/components/add_edit_product_dialog.dart';
import 'package:lin_chuck/views/home/components/delete_dialog.dart';
import 'package:lin_chuck/views/home/components/pay_by_cash_page.dart';
import 'package:lin_chuck/views/home/components/pay_by_promptpay.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/home/model/selected_product_model.dart';
import 'package:lin_chuck/views/promotion/controller/promotion_controller.dart';
import 'package:lin_chuck/views/sell_product/sell_product_page.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_ok_cancel_dialog.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  final EmployeeController _employeeController = Get.put(EmployeeController());
  final PromotionController _promotionController =
  Get.put(PromotionController());

  FlutterSecureStorage storage = const FlutterSecureStorage();

  String? userId;
  int currentIndex = 0;
  int currentPage = 0;

  List<ProductTypeModel> productTypeList = [];
  List<ProductModel> _filterProductList = [];
  List<String> popupItems = ['หมวดหมู่สินค้า', 'สินค้า'];

  bool payByCash = true;
  bool payByPromptPay = false;

  double total = 0.0;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    userId = await storage.read(key: 'user_id');

    await _homeController.getSweet();
    await _homeController.getProductType();
    await _getProductType();
    await _homeController.getProduct();
    await _getFilterProduct();
    await _employeeController.getOneEmployee(int.parse(userId.toString()));
    await _promotionController.getPromotion();

    setState(() {});
  }

  _getProductType() {
    productTypeList.clear();

    ProductTypeModel data = ProductTypeModel(
      id: 0,
      name: 'ทั้งหมด',
      quantity: _homeController.productTypeList.length,
    );

    productTypeList.add(data);

    for (ProductTypeModel productType in _homeController.productTypeList) {
      productTypeList.add(productType);
    }
  }

  _getFilterProduct() {
    if (currentIndex == 0) {
      _filterProductList = _homeController.productList;
    } else {
      _filterProductList = _homeController.productList
          .where((product) =>
              product.productTypeId == _homeController.selectedProductTypeId)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: currentPage == 0 ? 'รายการสินค้า' : 'ชำระเงิน',
          showBackButton: currentPage == 1 ? true : false,
          backFunction: currentPage == 1
              ? () {
                  currentPage = 0;

                  setState(() {});
                }
              : null,
          showActionButton: currentPage == 0 ? true : false,
          actionButton: _popUp(),
          contentWidget: [
            _content(),
            const SizedBox(width: 20.0),
            _orderListCard(),
          ],
        ),
        _loading(),
      ],
    );
  }

  _productType() {
    return SizedBox(
      height: 50.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productTypeList.length,
        itemBuilder: (context, index) {
          ProductTypeModel item = productTypeList[index];

          return CustomButton(
            onTap: () {
              currentIndex = index;
              _homeController.selectedProductTypeId = item.id;
              _getFilterProduct();

              setState(() {});
            },
            title: index != 0
                ? '${item.name} (${item.quantity})'
                : '${item.name} (${_homeController.productList.length})',
            isSelected: currentIndex == index,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginX2);
        },
      ),
    );
  }

  _content() {
    return currentPage == 0
        ? Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _productType(),
                const SizedBox(height: 20.0),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: marginX2,
                      crossAxisSpacing: marginX2,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: _filterProductList.length,
                    itemBuilder: (context, index) {
                      ProductModel item = _filterProductList[index];

                      return _menuCard(
                        product: item,
                        showSweet: item.productTypeId == 2,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        : Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _paymentTypeButton(
                      onTap: () {
                        payByPromptPay = false;
                        payByCash = true;

                        setState(() {});
                      },
                      imagePath: 'money.png',
                      isSelected: payByCash,
                    ),
                    _paymentTypeButton(
                      onTap: () {
                        payByPromptPay = true;
                        payByCash = false;

                        setState(() {});
                      },
                      imagePath: 'promptpay.png',
                      isSelected: payByPromptPay,
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Visibility(
                  visible: payByCash,
                  child: PayByCashPage(
                    total: total,
                    user: _employeeController.selectedEmployee,
                    onConfirm: () {
                      SelectedPaymentModel payment = SelectedPaymentModel(
                        user: _employeeController.selectedEmployee,
                        totalPrice: total,
                        payType: 'cash',
                        cashReceive:
                            double.parse(_homeController.receivedMoney ?? '0'),
                        cashReturn: _homeController.changeMoney,
                      );

                      _homeController.orderDetailPayment = payment;

                      setState(() {});
                    },
                    cancelOrder: () {
                      Get.dialog(
                        CustomOkCancelDialog(
                          title: 'ต้องการที่จะยกเลิกออเดอร์หรือไม่',
                          onOK: () {
                            currentPage = 0;
                            _homeController.receivedMoney = null;
                            _homeController.changeMoney = null;
                            _homeController.orderDetailPayment = null;
                            _homeController.orderDetailList.clear();

                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: payByPromptPay,
                  child: PayByPromptPay(
                    user: _employeeController.selectedEmployee,
                    total: total,
                  ),
                ),
              ],
            ),
          );
  }

  _menuCard({
    required ProductModel product,
    bool showSweet = false,
  }) {
    return InkWell(
      onTap: () async {
        bool? result = await Get.dialog(
          AddEditProductDialog(
            product: product,
            showSweet: showSweet,
          ),
        );

        if (result != null) {
          total = 0.0;

          for (SelectedProductModel product
              in _homeController.orderDetailList) {
            total += product.product!.productPrice! * product.quantity!;
          }

          setState(() {});
        }
      },
      child: Column(
        children: [
          //TODO: change to image.file
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.grey.shade700,
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
    );
  }

  _paymentTypeButton({
    required Function() onTap,
    required String imagePath,
    // required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 220.0,
        height: 150.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue.shade900 : Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Image.asset('assets/icons/$imagePath'),
        // child: Icon(icon),
      ),
    );
  }

  _orderListCard() {
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
            child: _homeController.orderDetailList.isNotEmpty
                ? ListView.separated(
                    itemCount: _homeController.orderDetailList.length,
                    itemBuilder: (context, index) {
                      SelectedProductModel item =
                          _homeController.orderDetailList[index];

                      return _selectedProduct(
                        product: item.product?.name ?? '',
                        quantity: item.quantity ?? 0,
                        price:
                            double.parse(item.product!.productPrice.toString()),
                        sweet: item.sweet != null
                            ? '${item.sweet!.name} (${item.sweet!.percent}%)'
                            : '',
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: marginX2);
                    },
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFontStyle(
                          'กรุณาเพิ่ม',
                          size: fontSizeM,
                          weight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                        TextFontStyle(
                          'สินค้าที่ต้องการ',
                          size: fontSizeM,
                          weight: FontWeight.bold,
                          color: Colors.white,
                          textAlign: TextAlign.center,
                        ),
                      ],
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
    String sweet = '',
  }) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Get.dialog(
                const AddEditProductDialog(),
              );
            },
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (context) {
              Get.dialog(const DeleteDialog()); //TODO:
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: marginX2,
          vertical: sweet != '' ? margin : marginX2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextFontStyle(
                  'x$quantity',
                  size: fontSizeM,
                  color: Colors.black,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Row(
                    children: [
                      TextFontStyle(
                        product,
                        size: fontSizeM,
                        color: primaryColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: margin),
                      TextFontStyle(
                        '($price)',
                        size: fontSizeS,
                        color: Colors.grey.shade700,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10.0),
                TextFontStyle(
                  '${price * quantity}',
                  size: fontSizeM,
                  color: Colors.red,
                ),
              ],
            ),
            Visibility(
              visible: sweet != '',
              child: Row(
                children: [
                  const SizedBox(width: 20.0),
                  TextFontStyle(
                    '- $sweet',
                    size: fontSizeS,
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
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
        Column(
          children: [
            Visibility(
              visible: _homeController.orderDetailPayment?.payType == 'cash',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextFontStyle(
                    'เงินที่ได้รับ',
                    color: Colors.white,
                    size: fontSizeM,
                    weight: FontWeight.bold,
                  ),
                  TextFontStyle(
                    (double.parse(_homeController.receivedMoney ?? '0'))
                        .toString(),
                    color: Colors.white,
                    size: fontSizeM,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFontStyle(
                  'รวม',
                  color: Colors.white,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
                TextFontStyle(
                  total.toString(),
                  color: Colors.white,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomSubmitButton(
            onTap: currentPage == 0
                ? () {
                    if (_homeController.orderDetailList.isNotEmpty) {
                      currentPage = 1;
                      setState(() {});
                    } else {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณาเพิ่มสินค้า'),
                      );
                    }
                  }
                : () async {
                    if (_homeController.orderDetailPayment == null) {
                      Get.dialog(
                        CustomAlertDialog(
                          title: payByCash
                              ? 'กรุณากดยืนยันการชำระเงิน'
                              : 'กรุณาอัพโหลดหลักฐานการชำระเงิน',
                        ),
                      );
                    } else {
                      await _homeController.createPayment(
                        _employeeController.selectedEmployee?.id ?? 0,
                        total,
                        _homeController.orderDetailPayment?.payType ?? '',
                        _homeController.orderDetailPayment?.payImage ?? '',
                        _homeController.orderDetailPayment?.cashReceive ?? 0,
                        _homeController.orderDetailPayment?.cashReturn ?? 0,
                      );
                    }
                  },
            title: currentPage == 0 ? 'ชำระเงิน' : 'บันทึกใบเสร็จ',
            backgroundColor: lYellow,
            fontColor: Colors.black,
          ),
        ),
      ],
    );
  }

  _popUp() {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return popupItems.map((data) {
          return PopupMenuItem<String>(
            value: data,
            child: InkWell(
              onTap: data == 'สินค้า'
                  ? () {
                      Get.back();
                      Get.to(() => const SellProductPage());
                    }
                  : () {
                      Get.back();
                      Get.to(() => const CategoryPage());
                    },
              child: TextFontStyle(
                data,
                size: fontSizeM,
              ),
            ),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      offset: const Offset(0, 30),
      child: const Icon(Icons.tune_rounded),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _homeController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
