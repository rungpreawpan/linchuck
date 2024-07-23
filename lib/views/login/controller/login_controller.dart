import 'package:get/get.dart';
import 'package:lin_chuck/views/home/home_page.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  String? username;
  String? password;

  login(String username, String password) async {
    // isLoading.value = true;

    Get.off(() => const HomePage());
  }

  verifyLogin(String username, String password) {
    if (username == '') {
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

    login(username, password);
  }

  // forgetPassword() {}

  // resetPassword() {}
}
