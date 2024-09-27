import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/login/register_success_page.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  verifyRegister(
    String firstname,
    String lastname,
    String email,
    String password,
    String employeeCode,
  ) async {
    if (firstname == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกชื่อ'),
      );

      return;
    }

    if (lastname == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกนามสกุล'),
      );

      return;
    }

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

    if (employeeCode == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกรหัสพนักงาน'),
      );

      return;
    }

    await employeeRegister(firstname, lastname, email, password, employeeCode);
  }

  employeeRegister(
    String firstname,
    String lastname,
    String email,
    String password,
    String employeeCode,
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
        '/user/employee/register',
        method: HttpMethod.post,
        data: {
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'uuid': employeeCode,
        },
      );

      if (response != null) {
        await storage.write(key: 'intro', value: 'true');
        Get.offAll(() => const RegisterSuccessPage());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
