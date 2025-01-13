import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/home/model/create_payment_model.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/home/model/selected_product_model.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';
import 'package:lin_chuck/views/home/order_complete_page.dart';
import 'package:lin_chuck/views/receipt/model/receipt_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  List<SweetModel> sweetList = [];
  SweetModel? selectedSweet;

  List<ProductModel> productList = [];
  List<ProductModel> selectedProductList = [];
  int? selectedProductId;
  ProductModel? selectedProduct;

  List<ProductTypeModel> productTypeList = [];
  int? selectedProductTypeId;
  List<ProductTypeModel> selectedProductTypeList = [];

  DateTime? orderDate;
  DateTime? expireDate;

  List<SelectedProductModel> orderDetailList = [];
  SelectedPaymentModel? orderDetailPayment;

  // ค่าที่ได้รับมาจากการยิง order
  CreatePaymentModel? createOrderPayment;
  List<CreateOrderModel> createOrderList = [];
  ReceiptModel? receipt;

  String? receivedMoney;
  double? changeMoney;

  File? promptPayImage;

  getSweet() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/sweet',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        sweetList = dataJSON
            .map<SweetModel>((json) => SweetModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getProductType() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/productType',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        productTypeList = dataJSON
            .map<ProductTypeModel>((json) => ProductTypeModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  addProductType(String productType) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/productType',
        method: HttpMethod.post,
        data: {'product_type': productType},
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'เพิ่มประเภทสินค้าสำเร็จ',
            onOk: () {
              Get.back(result: true);
            },
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  editProductType(int id, String productType) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request('/productType/$id',
          method: HttpMethod.post, data: {'product_type': productType});

      if (response != null) {
        Get.dialog(
          const CustomAlertDialog(title: 'แก้ไขหมวดหมู่สำเร็จ'),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  deleteProductType(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/productType/$id',
        method: HttpMethod.delete,
      );

      if (response != null && response.toString() == 'true') {
        Get.dialog(
          const CustomAlertDialog(title: 'ลบหมวดหมู่สำเร็จ'),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getProduct() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/product',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        productList = dataJSON
            .map<ProductModel>((json) => ProductModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneProduct(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/product/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        selectedProduct = ProductModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  addProduct(
    String? name,
    double? price,
    double? cost,
    int? quantity,
    int? productTypeId,
    String? orderDate,
    String? expireDate,
  ) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/product',
        method: HttpMethod.post,
        data: {
          'product_name': name,
          'product_price': price,
          'product_cost': cost,
          'product_quantity': quantity,
          'product_type_id': productTypeId,
          'product_image': 'test', //TODO:
          'order_date': orderDate,
          'expire_date': expireDate,
        },
      );

      if (response != null) {
        Get.back(result: true);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  editProduct(
    int id,
    String? name,
    double? price,
    double? cost,
    int? quantity,
    int? productTypeId,
    String? orderDate,
    String? expireDate,
  ) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/product/$id',
        method: HttpMethod.post,
        data: {
          'product_name': name,
          'product_price': price,
          'product_cost': cost,
          'product_quantity': quantity,
          'product_type_id': productTypeId,
          'product_image': 'test', //TODO:
          'order_date': orderDate,
          'expire_date': expireDate,
        },
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'แก้ไขสินค้าสำเร็จ',
            onOk: () {
              Get.back(result: true);
            },
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  deleteProduct(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/product/$id',
        method: HttpMethod.delete,
      );

      if (response != null && response.toString() == 'true') {
        Get.dialog(
          const CustomAlertDialog(title: 'ลบสินค้าสำเร็จ'),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  createPayment(
    int userId,
    double totalPrice,
    String payType,
    String payImage,
    double cashReceive,
    double cashReturn,
  ) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/payment',
        method: HttpMethod.post,
        data: payType == 'cash'
            ? {
                "receipt": {
                  "user_id": userId,
                },
                "payment": {
                  "total_price": totalPrice,
                  "pay_type": payType,
                  "cash_receive": cashReceive,
                  "cash_return": cashReturn,
                }
              }
            : {
                "receipt": {
                  "user_id": userId,
                },
                "payment": {
                  "total_price": totalPrice,
                  "pay_type": payType,
                  "pay_image": payImage,
                }
              },
      );

      if (response != null) {
        var dataJSON = response.data;
        createOrderPayment = CreatePaymentModel.fromJSON(dataJSON);

        await createOrder(createOrderPayment?.paymentId ?? 0);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  createOrder(int paymentId) async {
    bool isOnline = await RequestService().checkInternetConnection();
    List<OrderPaymentModel> createOrderDetailList = [];

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    for (SelectedProductModel selectedProduct in orderDetailList) {
      OrderPaymentModel orderDetail = OrderPaymentModel(
        productId: selectedProduct.product?.id ?? 0,
        sweetId: selectedProduct.sweet?.id,
        quantity: selectedProduct.quantity ?? 0,
      );

      createOrderDetailList.add(orderDetail);
    }

    String jsonList = jsonEncode(
        createOrderDetailList.map((model) => model.toJson()).toList());

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/order/$paymentId',
        method: HttpMethod.post,
        data: jsonList,
      );

      if (response != null) {
        var dataJSON = response.data;
        createOrderList = dataJSON
            .map<CreateOrderModel>((json) => CreateOrderModel.fromJSON(json))
            .toList();

        await getOneReceipt(createOrderPayment?.receiptId ?? 0);
        Get.off(() => const OrderCompletePage());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneReceipt(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/receipt/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        receipt = ReceiptModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
