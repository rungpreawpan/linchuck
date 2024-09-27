import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/home/home_page.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  FlutterSecureStorage storage = const FlutterSecureStorage();

  List<UserModel> userList = [];

  // UserModel? user;

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

      if (response != null) {
        var dataJSON = response.data;
        userList = dataJSON
            .map<UserModel>((json) => UserModel.fromJSON(json))
            .toList();

        await storage.write(key: 'intro', value: 'true');
        await storage.write(key: 'login', value: 'true');
        await storage.write(key: 'firstname', value: userList.first.firstname);
        await storage.write(key: 'lastname', value: userList.first.lastname);
        await storage.write(key: 'position', value: userList.first.role);
        await storage.write(key: 'image', value: userList.first.image);

        await Get.offAll(() => const HomePage());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
