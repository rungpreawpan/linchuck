import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/login/login_page.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';
import 'package:lin_chuck/views/login/reset_password_page.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class ForgetPasswordController extends GetxController {
  var isLoading = false.obs;

  int? userId;

  verifyEmail(String email) async {
    if (email == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกอีเมล'),
      );

      return;
    }

    await forgetPassword(email);
  }

  verifyPassword(String newPassword, String confirmPassword) async {
    if (newPassword == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกรหัสผ่านใหม่'),
      );

      return;
    }

    if (confirmPassword == '') {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกรหัสผ่านใหม่'),
      );

      return;
    }

    if (newPassword != confirmPassword) {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณากรอกรหัสผ่านให้เหมือนกัน'),
      );

      return;
    }

    await resetPassword(newPassword, confirmPassword);
  }

  forgetPassword(String email) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request('/user/forget',
          method: HttpMethod.post, data: {'email': email});

      if (response != null) {
        Map<String, dynamic> dataJSON = response.data;
        UserModel user = UserModel.fromJSON(dataJSON['message']);
        userId = user.id;

        await Get.to(() => const ResetPasswordPage());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  resetPassword(String password, String confirmPassword) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/user/newpass',
        method: HttpMethod.post,
        data: {
          'user_id': userId,
          'password': password,
        },
      );

      // TODO:
      if (response != null) {
        await Get.dialog(
          CustomAlertDialog(
            title: 'เปลี่ยนรหัสผ่านสำเร็จ',
            onOk: () {
              Get.offAll(() => const LoginPage());
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
