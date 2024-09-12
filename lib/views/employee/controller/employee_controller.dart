import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';

class EmployeeController {
  var isLoading = false.obs;

  getEmployee() async {

  }

  addEmployee() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/user/manager/add',
        method: HttpMethod.post,
      );
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}