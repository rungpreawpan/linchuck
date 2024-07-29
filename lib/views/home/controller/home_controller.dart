import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/model/data_model.dart';
import 'package:lin_chuck/views/home/model/options_model.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  List categoryList = [];
  List selectedCategoryList = [];

  List optionList = [];
  List selectedOptionList = [];

  getCategories() async {
    String content =
        await rootBundle.loadString('assets/data/sales_categories.json');

    Map<String, dynamic> dataMap = jsonDecode(content);
    List dataJSON = dataMap['data'];

    categoryList =
        List.from(dataJSON).map((e) => DataModel.fromJSON(e)).toList();
  }

  getOptions() async {
    String content =
        await rootBundle.loadString('assets/data/options.json');

    Map<String, dynamic> dataMap = jsonDecode(content);
    List dataJSON = dataMap['data'];

    optionList =
        List.from(dataJSON).map((e) => OptionsModel.fromJSON(e)).toList();
  }
}
