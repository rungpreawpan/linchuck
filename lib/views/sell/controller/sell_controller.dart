import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/sell/model/sell_model.dart';

class SellController extends GetxController {
  var isLoading = false.obs;

  SellModel? sellData;

  SellModel? janData;
  SellModel? febData;
  SellModel? marData;
  SellModel? aprData;
  SellModel? mayData;
  SellModel? junData;
  SellModel? julData;
  SellModel? augData;
  SellModel? sepData;
  SellModel? octData;
  SellModel? novData;
  SellModel? decData;

  getAllData(String startDate, String endDate) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/report?startDate=$startDate&endDate=$endDate',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        sellData = SellModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getFinance() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      /// january
      var janResponse = await RequestService().request(
        '/report?startDate=2024-01-01 00:00:00&endDate=2024-01-31 23:59:59',
        method: HttpMethod.get,
      );

      if (janResponse != null) {
        var dataJSON = janResponse.data;
        janData = SellModel.fromJSON(dataJSON);
      }

      /// febuary
      var febResponse = await RequestService().request(
        '/report?startDate=2024-02-01 00:00:00&endDate=2024-02-28 23:59:59',
        method: HttpMethod.get,
      );

      if (febResponse != null) {
        var dataJSON = febResponse.data;
        febData = SellModel.fromJSON(dataJSON);
      }

      /// march
      var marResponse = await RequestService().request(
        '/report?startDate=2024-03-01 00:00:00&endDate=2024-03-31 23:59:59',
        method: HttpMethod.get,
      );

      if (marResponse != null) {
        var dataJSON = marResponse.data;
        marData = SellModel.fromJSON(dataJSON);
      }

      /// april
      var aprResponse = await RequestService().request(
        '/report?startDate=2024-04-01 00:00:00&endDate=2024-04-30 23:59:59',
        method: HttpMethod.get,
      );

      if (aprResponse != null) {
        var dataJSON = aprResponse.data;
        aprData = SellModel.fromJSON(dataJSON);
      }

      /// may
      var mayResponse = await RequestService().request(
        '/report?startDate=2024-05-01 00:00:00&endDate=2024-05-31 23:59:59',
        method: HttpMethod.get,
      );

      if (mayResponse != null) {
        var dataJSON = mayResponse.data;
        mayData = SellModel.fromJSON(dataJSON);
      }

      /// june
      var junResponse = await RequestService().request(
        '/report?startDate=2024-06-01 00:00:00&endDate=2024-06-30 23:59:59',
        method: HttpMethod.get,
      );

      if (junResponse != null) {
        var dataJSON = junResponse.data;
        junData = SellModel.fromJSON(dataJSON);
      }

      /// july
      var julResponse = await RequestService().request(
        '/report?startDate=2024-07-01 00:00:00&endDate=2024-07-31 23:59:59',
        method: HttpMethod.get,
      );

      if (julResponse != null) {
        var dataJSON = julResponse.data;
        julData = SellModel.fromJSON(dataJSON);
      }

      /// August
      var augResponse = await RequestService().request(
        '/report?startDate=2024-08-01 00:00:00&endDate=2024-08-31 23:59:59',
        method: HttpMethod.get,
      );

      if (augResponse != null) {
        var dataJSON = augResponse.data;
        augData = SellModel.fromJSON(dataJSON);
      }

      /// september
      var sepResponse = await RequestService().request(
        '/report?startDate=2024-09-01 00:00:00&endDate=2024-09-30 23:59:59',
        method: HttpMethod.get,
      );

      if (sepResponse != null) {
        var dataJSON = sepResponse.data;
        sepData = SellModel.fromJSON(dataJSON);
      }

      /// october
      var octResponse = await RequestService().request(
        '/report?startDate=2024-10-01 00:00:00&endDate=2024-10-31 23:59:59',
        method: HttpMethod.get,
      );

      if (octResponse != null) {
        var dataJSON = octResponse.data;
        octData = SellModel.fromJSON(dataJSON);
      }

      /// november
      var novResponse = await RequestService().request(
        '/report?startDate=2024-11-01 00:00:00&endDate=2024-11-30 23:59:59',
        method: HttpMethod.get,
      );

      if (novResponse != null) {
        var dataJSON = novResponse.data;
        novData = SellModel.fromJSON(dataJSON);
      }

      /// december
      var decResponse = await RequestService().request(
        '/report?startDate=2024-12-01 00:00:00&endDate=2024-12-31 23:59:59',
        method: HttpMethod.get,
      );

      if (decResponse != null) {
        var dataJSON = decResponse.data;
        decData = SellModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
