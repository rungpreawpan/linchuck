import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/home/home_page.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  verifyLogin(String email, String password) async {
    if (email == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกอีเมล'),
      );

      return;
    }

    if (password == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกรหัสผ่าน'),
      );

      return;
    }

    await login(email, password);
  }

  login(String email, String password) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/user/login',
        method: HttpMethod.post,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response != null && response.toString() == 'true') {
        Get.offAll(() => const HomePage());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
