import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class EmployeeController {
  var isLoading = false.obs;

  List<UserModel> employeeList = [];

  int? selectedEmployeeId;
  UserModel? selectedEmployee;

  getEmployee() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/user',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        employeeList = dataJSON
            .map<UserModel>((json) => UserModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneEmployee(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/user/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        selectedEmployee = UserModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  addEmployee(
    String? firstname1,
    String? lastname1,
    String? firstname2,
    String? lastname2,
    String? firstname3,
    String? lastname3,
    String? firstname4,
    String? lastname4,
    String? firstname5,
    String? lastname5,
  ) async {
    // print(employeeList);
    var nameList;

    if (firstname1 != null &&
        lastname1 != null &&
        firstname2 != null &&
        lastname2 != null &&
        firstname3 != null &&
        lastname3 != null &&
        firstname4 != null &&
        lastname4 != null &&
        firstname5 != null &&
        lastname5 != null) {
      nameList = [
        {
          'firstname': firstname1,
          'lastname': lastname1,
        },
        {
          'firstname': firstname2,
          'lastname': lastname2,
        },
        {
          'firstname': firstname3,
          'lastname': lastname3,
        },
        {
          'firstname': firstname4,
          'lastname': lastname4,
        },
        {
          'firstname': firstname5,
          'lastname': lastname5,
        }
      ];
    } else if (firstname1 != null &&
        lastname1 != null &&
        firstname2 != null &&
        lastname2 != null &&
        firstname3 != null &&
        lastname3 != null &&
        firstname4 != null &&
        lastname4 != null) {
      nameList = [
        {
          'firstname': firstname1,
          'lastname': lastname1,
        },
        {
          'firstname': firstname2,
          'lastname': lastname2,
        },
        {
          'firstname': firstname3,
          'lastname': lastname3,
        },
        {
          'firstname': firstname4,
          'lastname': lastname4,
        }
      ];
    } else if (firstname1 != null &&
        lastname1 != null &&
        firstname2 != null &&
        lastname2 != null &&
        firstname3 != null &&
        lastname3 != null) {
      nameList = [
        {
          'firstname': firstname1,
          'lastname': lastname1,
        },
        {
          'firstname': firstname2,
          'lastname': lastname2,
        },
        {
          'firstname': firstname3,
          'lastname': lastname3,
        }
      ];
    } else if (firstname1 != null &&
        lastname1 != null &&
        firstname2 != null &&
        lastname2 != null) {
      nameList = [
        {
          'firstname': firstname1,
          'lastname': lastname1,
        },
        {
          'firstname': firstname2,
          'lastname': lastname2,
        }
      ];
    } else if (firstname1 != null && lastname1 != null) {
      nameList = [
        {
          'firstname': firstname1,
          'lastname': lastname1,
        }
      ];
    }

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
        data: nameList,
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'เพิ่มพนักงานสำเร็จ',
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

  editEmployee(
    int id,
    String firstname,
    String lastname,
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
        '/user/$id',
        method: HttpMethod.post,
        data: {
          'firstname': firstname,
          'lastname': lastname,
        },
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'แก้ไขรายชื่อพนักงานสำเร็จ',
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

  deleteEmployee(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/user/$id',
        method: HttpMethod.delete,
      );

      if (response != null) {
        Get.dialog(
          const CustomAlertDialog(title: 'ลบรายชื่อพนักงานสำเร็จ'),
        );
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
