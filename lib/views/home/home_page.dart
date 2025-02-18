import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
import 'package:lin_chuck/views/recipe/controller/recipe_controller.dart';
import 'package:lin_chuck/views/sell_product/sell_product_page.dart';
import 'package:lin_chuck/views/stock/controller/stock_controller.dart';
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
  final RecipeController _recipeController = Get.put(RecipeController());
  final StockController _stockController = Get.put(StockController());

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
  double discountAmount = 0.0;

  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    isLoading.value = true;
    userId = await storage.read(key: 'user_id');

    await _homeController.getSweet();
    await _homeController.getProductType();
    await _getProductType();
    await _homeController.getProduct();
    await _getFilterProduct();
    await _employeeController.getOneEmployee(int.parse(userId.toString()));
    await _promotionController.getPromotion();
    await _recipeController.getUnit();
    await _stockController.getIngredient();
    isLoading.value = false;

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
                  if (_homeController.orderDetailPayment != null) {
                    _homeController.orderDetailPayment = null;
                  }

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
                        discount: item.discountAmount,
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
                    discountAmount: discountAmount,
                    user: _employeeController.selectedEmployee,
                    onConfirm: () {
                      if (_homeController.changeMoney != null &&
                          _homeController.changeMoney! < 0) {
                        Get.dialog(
                            CustomAlertDialog(title: 'กรุณากรอกเงินที่ได้รับ'));
                      } else {
                        SelectedPaymentModel payment = SelectedPaymentModel(
                          user: _employeeController.selectedEmployee,
                          totalPrice: total,
                          payType: 'cash',
                          cashReceive: double.parse(
                              _homeController.receivedMoney ?? '0'),
                          cashReturn: _homeController.changeMoney,
                        );

                        _homeController.orderDetailPayment = payment;
                        setState(() {});
                      }
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
                            total = 0.0;

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
    int? discount,
    bool showSweet = false,
  }) {
    return InkWell(
      onTap: () async {
        SelectedProductModel? result = await Get.dialog(
          AddEditProductDialog(
            product: product,
            showSweet: showSweet,
            qty: 1,
          ),
        );

        if (result != null) {
          discountAmount = 0.0;
          total = 0.0;

          bool productExists = false;

          List<SelectedProductModel> updatedList = [];

          for (SelectedProductModel order in _homeController.orderDetailList) {
            if (result.product!.id! == order.product!.id!) {
              productExists = true;
              updatedList.add(
                SelectedProductModel(
                  product: order.product,
                  quantity: order.quantity! + result.quantity!,
                ),
              );
            } else {
              updatedList.add(order);
            }
          }

          if (!productExists) {
            updatedList.add(result);
          }

          _homeController.orderDetailList = updatedList;

          for (SelectedProductModel product
              in _homeController.orderDetailList) {
            total += product.product!.productPrice! * product.quantity!;
            if (product.product?.promotionId != null) {
              discountAmount +=
                  product.product!.discountAmount! * product.quantity!;
            }
          }

          setState(() {});
        }
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              child: product.promotionId == null
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: product.productImage != null &&
                                  product.productImage!.length > 6
                              ? SizedBox.expand(
                                  child: Image.memory(
                                    base64Decode(product.productImage ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child:
                                      Icon(Icons.image_not_supported_outlined),
                                ),
                        ),
                      ),
                    )
                  : Banner(
                      message: discount != null ? 'ลด $discount.-' : '',
                      location: BannerLocation.topEnd,
                      color: Colors.red,
                      textStyle: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.kanit().fontFamily,
                        overflow: TextOverflow.ellipsis,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: product.productImage != null &&
                                  product.productImage!.length > 6
                              ? SizedBox.expand(
                                  child: Image.memory(
                                    base64Decode(product.productImage ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child:
                                      Icon(Icons.image_not_supported_outlined),
                                ),
                        ),
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
    return ClipRRect(
      child: Container(
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
                          price: item.product != null
                              ? double.parse(
                                  item.product!.productPrice.toString())
                              : 0,
                          onEdit: (context) async {
                            SelectedProductModel? result = await Get.dialog(
                              AddEditProductDialog(
                                isEdit: true,
                                qty: item.quantity ?? 1,
                              ),
                            );

                            if (result != null) {
                              SelectedProductModel editOrder =
                                  SelectedProductModel(
                                product: item.product,
                                quantity: result.quantity,
                              );

                              _homeController.orderDetailList[index] =
                                  editOrder;

                              discountAmount = 0.0;
                              total = 0.0;
                              for (SelectedProductModel order
                                  in _homeController.orderDetailList) {
                                total += order.product!.productPrice! *
                                    order.quantity!;
                                if (order.product?.promotionId != null) {
                                  discountAmount +=
                                      order.product!.discountAmount! *
                                          order.quantity!;
                                }
                              }

                              setState(() {});
                            }
                          },
                          onDelete: (context) async {
                            bool? result =
                                await Get.dialog(const DeleteDialog());

                            if (result != null) {
                              _homeController.orderDetailList.removeAt(index);

                              discountAmount = 0.0;
                              total = 0.0;
                              if (_homeController.orderDetailList.isEmpty) {
                                total = 0.0;
                                discountAmount = 0.0;
                              } else {
                                for (SelectedProductModel order
                                    in _homeController.orderDetailList) {
                                  total += order.product!.productPrice! *
                                      order.quantity!;
                                  if (order.product?.promotionId != null) {
                                    discountAmount +=
                                        order.product!.discountAmount! *
                                            order.quantity!;
                                  }
                                }
                              }

                              setState(() {});
                            }
                          },
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
      ),
    );
  }

  _selectedProduct({
    required String product,
    required int quantity,
    required double price,
    required void Function(BuildContext)? onEdit,
    required void Function(BuildContext)? onDelete,
    String sweet = '',
  }) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onEdit,
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: onDelete,
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
                  'ราคารวม',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFontStyle(
                  'ส่วนลด',
                  color: Colors.white,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
                TextFontStyle(
                  discountAmount.toString(),
                  color: Colors.white,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextFontStyle(
                  'ราคาสุทธิ',
                  color: Colors.white,
                  size: fontSizeM,
                  weight: FontWeight.bold,
                ),
                TextFontStyle(
                  (total - discountAmount).toString(),
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
                      if (payByCash) {
                        if (_homeController.orderDetailPayment?.cashReceive !=
                                null &&
                            total - discountAmount >
                                _homeController
                                    .orderDetailPayment!.cashReceive!) {
                          Get.dialog(CustomAlertDialog(
                              title: 'กรุณาแก้ไขเงินที่ได้รับ'));
                        } else {
                          await _homeController.createPayment(
                            userId:
                                _employeeController.selectedEmployee?.id ?? 0,
                            totalPrice: total,
                            payType: 'cash',
                            payImage: null,
                            cashReceive: _homeController
                                    .orderDetailPayment?.cashReceive ??
                                0,
                            cashReturn: _homeController
                                    .orderDetailPayment?.cashReturn ??
                                0,
                          );
                        }
                      } else {
                        _homeController.orderDetailPayment?.cashReceive =
                            total - discountAmount;

                        await _homeController.createPayment(
                          userId: _employeeController.selectedEmployee?.id ?? 0,
                          totalPrice:
                              _homeController.orderDetailPayment?.cashReceive ??
                                  0,
                          payType: 'promptpay',
                          payImage:
                              _homeController.orderDetailPayment?.payImage,
                        );
                      }
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
    return Row(
      children: [
        InkWell(
          onTap: () async {
            await _prepareData();
          },
          child: const Icon(Icons.refresh_rounded),
        ),
        const SizedBox(width: marginX2),
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return popupItems.map((data) {
              return PopupMenuItem<String>(
                value: data,
                child: InkWell(
                  onTap: data == 'สินค้า'
                      ? () {
                          Get.back();
                          Get.to(() =>
                              const SellProductPage(isFromHomePage: true));
                        }
                      : () {
                          Get.back();
                          Get.to(
                              () => const CategoryPage(isFromHomePage: true));
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
        ),
      ],
    );
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
