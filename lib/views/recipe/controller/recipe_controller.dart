import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/recipe/model/unit_model.dart';

class RecipeController extends GetxController {
  var isLoading = false.obs;

  List<UnitModel> unitList = [];

  getUnit() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/unit',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        unitList = dataJSON
            .map<UnitModel>((json) => UnitModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
