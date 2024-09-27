import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';
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
}
