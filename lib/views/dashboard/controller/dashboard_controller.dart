import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/dashboard/model/dashboard_model.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;

  DashboardModel? dashboardData;
  DashboardModel? reportData;

  DashboardModel? janData;
  DashboardModel? febData;
  DashboardModel? marData;
  DashboardModel? aprData;
  DashboardModel? mayData;
  DashboardModel? junData;
  DashboardModel? julData;
  DashboardModel? augData;
  DashboardModel? sepData;
  DashboardModel? octData;
  DashboardModel? novData;
  DashboardModel? decData;

  getReportData(String startDate, String endDate) async {
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
        reportData = DashboardModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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
        dashboardData = DashboardModel.fromJSON(dataJSON);
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
        '/report?startDate=${DateTime.now().year}-01-01 00:00:00&endDate=${DateTime.now().year}-01-31 23:59:59',
        method: HttpMethod.get,
      );

      if (janResponse != null) {
        var dataJSON = janResponse.data;
        janData = DashboardModel.fromJSON(dataJSON);
      }

      /// febuary
      int febDay = 28;
      if (DateTime.now().year %4 == 0) {
        febDay = 29;
      }

      var febResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-02-01 00:00:00&endDate=${DateTime.now().year}-02-$febDay 23:59:59',
        method: HttpMethod.get,
      );

      if (febResponse != null) {
        var dataJSON = febResponse.data;
        febData = DashboardModel.fromJSON(dataJSON);
      }

      /// march
      var marResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-03-01 00:00:00&endDate=${DateTime.now().year}-03-31 23:59:59',
        method: HttpMethod.get,
      );

      if (marResponse != null) {
        var dataJSON = marResponse.data;
        marData = DashboardModel.fromJSON(dataJSON);
      }

      /// april
      var aprResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-04-01 00:00:00&endDate=${DateTime.now().year}-04-30 23:59:59',
        method: HttpMethod.get,
      );

      if (aprResponse != null) {
        var dataJSON = aprResponse.data;
        aprData = DashboardModel.fromJSON(dataJSON);
      }

      /// may
      var mayResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-05-01 00:00:00&endDate=${DateTime.now().year}-05-31 23:59:59',
        method: HttpMethod.get,
      );

      if (mayResponse != null) {
        var dataJSON = mayResponse.data;
        mayData = DashboardModel.fromJSON(dataJSON);
      }

      /// june
      var junResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-06-01 00:00:00&endDate=${DateTime.now().year}-06-30 23:59:59',
        method: HttpMethod.get,
      );

      if (junResponse != null) {
        var dataJSON = junResponse.data;
        junData = DashboardModel.fromJSON(dataJSON);
      }

      /// july
      var julResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-07-01 00:00:00&endDate=${DateTime.now().year}-07-31 23:59:59',
        method: HttpMethod.get,
      );

      if (julResponse != null) {
        var dataJSON = julResponse.data;
        julData = DashboardModel.fromJSON(dataJSON);
      }

      /// August
      var augResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-08-01 00:00:00&endDate=${DateTime.now().year}-08-31 23:59:59',
        method: HttpMethod.get,
      );

      if (augResponse != null) {
        var dataJSON = augResponse.data;
        augData = DashboardModel.fromJSON(dataJSON);
      }

      /// september
      var sepResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-09-01 00:00:00&endDate=${DateTime.now().year}-09-30 23:59:59',
        method: HttpMethod.get,
      );

      if (sepResponse != null) {
        var dataJSON = sepResponse.data;
        sepData = DashboardModel.fromJSON(dataJSON);
      }

      /// october
      var octResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-10-01 00:00:00&endDate=${DateTime.now().year}-10-31 23:59:59',
        method: HttpMethod.get,
      );

      if (octResponse != null) {
        var dataJSON = octResponse.data;
        octData = DashboardModel.fromJSON(dataJSON);
      }

      /// november
      var novResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-11-01 00:00:00&${DateTime.now().year}=2024-11-30 23:59:59',
        method: HttpMethod.get,
      );

      if (novResponse != null) {
        var dataJSON = novResponse.data;
        novData = DashboardModel.fromJSON(dataJSON);
      }

      /// december
      var decResponse = await RequestService().request(
        '/report?startDate=${DateTime.now().year}-12-01 00:00:00&endDate=${DateTime.now().year}-12-31 23:59:59',
        method: HttpMethod.get,
      );

      if (decResponse != null) {
        var dataJSON = decResponse.data;
        decData = DashboardModel.fromJSON(dataJSON);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
