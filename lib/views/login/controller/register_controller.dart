import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/login/register_success_page.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  verifyRegister(
    String firstname,
    String lastname,
    String email,
    String password,
    String role,
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

    if (role == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณาเลือกตำแหน่ง'),
      );

      return;
    }

    if (employeeCode == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกรหัสพนักงาน'),
      );

      return;
    }

    if (role == 'manager') {
      await managerRegister(
          firstname, lastname, email, password, role, employeeCode);
    } else if (role == 'employee') {
      await employeeRegister(
          firstname, lastname, email, password, role, employeeCode);
    }
  }

  managerRegister(
    String firstname,
    String lastname,
    String email,
    String password,
    String role,
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
        '/user/manager/register',
        method: HttpMethod.post,
        data: {
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'role': role,
          // 'uuid': employeeCode,
        },
      );

      //TODO: edit response
      if (response != null) {
        Get.offAll(() => const RegisterSuccessPage());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  employeeRegister(
    String firstname,
    String lastname,
    String email,
    String password,
    String role,
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
          'role': role,
          'uuid': employeeCode,
        },
      );

      //TODO: edit condition
      if (response != null) {
        print(response);
        // Get.off(() => const RegisterSuccessPage());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
