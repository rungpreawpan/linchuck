import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/model/data_model.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/home/model/options_model.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/home/model/sweet_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  List categoryList = [];
  List selectedCategoryList = [];

  List optionList = [];
  List selectedOptionList = [];

  List<SweetModel> sweetList = [];
  List<ProductModel> productList = [];
  List<ProductTypeModel> productTypeList = [];
  List<ProductTypeModel> selectedProductTypeList = [];

  getCategories() async {
    String content =
        await rootBundle.loadString('assets/data/sales_categories.json');

    Map<String, dynamic> dataMap = jsonDecode(content);
    List dataJSON = dataMap['data'];

    categoryList =
        List.from(dataJSON).map((e) => DataModel.fromJSON(e)).toList();
  }

  getOptions() async {
    String content = await rootBundle.loadString('assets/data/options.json');

    Map<String, dynamic> dataMap = jsonDecode(content);
    List dataJSON = dataMap['data'];

    optionList =
        List.from(dataJSON).map((e) => OptionsModel.fromJSON(e)).toList();
  }

  getSweet() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));

      var response = await RequestService().request(
        '/sweet',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        sweetList = dataJSON
            .map<SweetModel>((json) => SweetModel.fromJSON(json))
            .toList();
      }
    } finally {
      isLoading.value = false;
    }
  }

  getProductType() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));

      var response = await RequestService().request(
        '/productType',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        productTypeList = dataJSON
            .map<ProductTypeModel>((json) => ProductTypeModel.fromJSON(json))
            .toList();
      }
    } finally {
      isLoading.value = false;
    }
  }

  getProduct() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));

      var response = await RequestService().request(
        '/product',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        productList = dataJSON
            .map<ProductModel>((json) => ProductModel.fromJSON(json))
            .toList();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
