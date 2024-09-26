import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/receipt/model/order_detail_model.dart';
import 'package:lin_chuck/views/receipt/model/order_model.dart';
import 'package:lin_chuck/views/receipt/model/payment_model.dart';
import 'package:lin_chuck/views/receipt/model/receipt_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class ReceiptController extends GetxController {
  var isLoading = false.obs;

  List<ReceiptModel> receiptList = [];
  ReceiptModel? receipt;

  List<PaymentModel> paymentList = [];
  PaymentModel? payment;

  List<OrderModel> orderList = [];
  OrderModel? order;

  List<OrderDetailModel> orderDetailList = [];
  OrderDetailModel? orderDetail;

  List<OrderDetailModel> orderDetailByIdList = [];

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

  createReceipt(int userId) async {
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
        data: {'user_id': userId},
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

  createPayment(
    int userId,
    double totalPrice,
    String payType,
    String payImage,
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
        '/payment',
        method: HttpMethod.post,
        data: {
          "receipt": {"user_id": userId},
          "payment": {
            "total_price": totalPrice,
            "pay_type": payImage,
          }
        },
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

  getOrder() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/order',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        orderList = dataJSON
            .map<OrderModel>((json) => OrderModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneOrder(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/order/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        order = OrderModel.fromJSON(dataJSON);
        // print(order);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  createOrder() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/order',
        method: HttpMethod.post,
        data: {
        //TODO:
        },
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

  getOrderDetail() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/order-detail',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        orderDetailList = dataJSON
            .map<OrderDetailModel>((json) => OrderDetailModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneOrderDetail(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/order-detail/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        orderDetail = OrderDetailModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOrderDetailById(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/order-detail/order/$id',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        orderDetailByIdList = dataJSON
            .map<OrderDetailModel>((json) => OrderDetailModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

// createOrderDetail() async {}
}
