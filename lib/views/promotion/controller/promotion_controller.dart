import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/promotion/model/promotion_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class PromotionController extends GetxController {
  var isLoading = false.obs;

  List<PromotionModel> promotionList = [];

  int? selectedPromotionId;
  PromotionModel? selectedPromotion;

  getPromotion() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/promotion',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        promotionList = dataJSON
            .map<PromotionModel>((json) => PromotionModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOnePromotion(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/promotion/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        selectedPromotion = PromotionModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  createPromotion({
    required String promotionName,
    required int productId,
    required int discountAmount,
    required String startDate,
    required String endDate,
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
        '/promotion',
        method: HttpMethod.post,
        data: {
          'promotion_name': promotionName,
          'discount_amount': discountAmount,
          'start_date': startDate,
          'end_date': endDate,
          'product_id': productId,
        },
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'เพิ่มโปรโมชั่นสำเร็จ',
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

  deletePromotion(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/promotion/$id',
        method: HttpMethod.delete,
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'ลบโปรโมชั่นสำเร็จ',
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
