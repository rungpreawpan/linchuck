import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  List optionList = [];
  List selectedOptionList = [];

  List<SweetModel> sweetList = [];
  SweetModel? selectedSweet;

  List<ProductModel> productList = [];

  List<ProductTypeModel> productTypeList = [];
  List<ProductTypeModel> selectedProductTypeList = [];

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
    } finally {
      isLoading.value = false;
    }
  }

  addProductType() async {
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
        // data: {}, //TODO:
      );

      if (response != null) {
        Get.dialog(
          const CustomAlertDialog(title: 'เพิ่มประเภทสินค้าสำเร็จ'),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  editProductType(int id) async {
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
        method: HttpMethod.post,
      );

      if (response != null) {
        //TODO: show dialog
      }
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

      if (response != null) {
        //TODO: show dialog
      }
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
    } finally {
      isLoading.value = false;
    }
  }

  editProduct(int id) async {
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
      );

      if (response != null) {
        //TODO: show dialog
      }
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

      if (response != null) {
        //TODO: show dialog
      }
    } finally {
      isLoading.value = false;
    }
  }
}
