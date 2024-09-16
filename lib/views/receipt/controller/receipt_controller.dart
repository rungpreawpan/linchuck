import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/receipt/model/payment_model.dart';
import 'package:lin_chuck/views/receipt/model/receipt_model.dart';

class ReceiptController extends GetxController {
  var isLoading = false.obs;

  List<ReceiptModel> receiptList = [];
  ReceiptModel? receipt;

  List<PaymentModel> paymentList = [];
  PaymentModel? payment;

  getReceipt() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/receipt',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        receiptList = dataJSON
            .map<ReceiptModel>((json) => ReceiptModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneReceipt(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/receipt/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        receipt = ReceiptModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  createReceipt() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/receipt',
        method: HttpMethod.post,
      );

      if (response != null) {
        //TODO:
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getPayment() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/payment',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        paymentList = dataJSON
            .map<PaymentModel>((json) => PaymentModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOnePayment(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/payment/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        payment = PaymentModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  createPayment() async {}

  getOrder() async {}

  getOneOrder(int id) async {}

  createOrder() async {}

  getOrderDetail() async {}

  getOneOrderDetail(int id) async {}

  getOrderDetailById(int id) async {}

  createOrderDetail() async {}
}
