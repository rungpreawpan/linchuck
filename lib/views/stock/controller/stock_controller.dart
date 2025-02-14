import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/stock/model/stock_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class StockController extends GetxController {
  var isLoading = false.obs;

  List<StockModel> stockList = [];
  List<StockModel> selectedStockList = [];
  StockModel? selectedStock;
  int? selectedStockId;

  getIngredient() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/ingredients',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        stockList = dataJSON
            .map<StockModel>((json) => StockModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneIngredient(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/ingredients/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        selectedStock = StockModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  addIngredient({
    required String ingredientName,
    required int unitId,
    required String unitName,
    required int orderAmount,
    required String lotNumber,
    required String orderDate,
    required String expireDate,
  }) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/ingredients',
        method: HttpMethod.post,
        data: {
          "ingredients_type": ingredientName,
          "ingredients_name": ingredientName,
          "unit_id": unitId,
          "unit_name": unitName,
          "order_amount": orderAmount,
          "remain": orderAmount,
          "lot_number": lotNumber,
          "order_date": orderDate,
          "expire_date": expireDate,
        },
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'เพิ่มวัตถุดิบสำเร็จ',
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

  editIngredient({
    required int id,
    required String ingredientName,
    required int unitId,
    required String unitName,
    required int orderAmount,
    required String lotNumber,
    required String orderDate,
    required String expireDate,
  }) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/ingredients/$id',
        method: HttpMethod.post,
        data: {
          "ingredients_type": ingredientName,
          "ingredients_name": ingredientName,
          "unit_id": unitId,
          "unit_name": unitName,
          "order_amount": orderAmount,
          "remain": orderAmount,
          "lot_number": lotNumber,
          "order_date": orderDate,
          "expire_date": expireDate,
        },
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'แก้ไขวัตถุดิบสำเร็จ',
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

  deleteIngredient(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/ingredients/$id',
        method: HttpMethod.delete,
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'ลบวัตถุดิบสำเร็จ',
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
}
