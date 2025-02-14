import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:lin_chuck/service/request_service.dart';
import 'package:lin_chuck/utils/alert.dart';
import 'package:lin_chuck/views/recipe/model/ingredient_model.dart';
import 'package:lin_chuck/views/recipe/model/recipe_model.dart';
import 'package:lin_chuck/views/recipe/model/unit_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';

class RecipeController extends GetxController {
  var isLoading = false.obs;

  List<UnitModel> unitList = [];
  List<UnitModel> selectedUnit = [];

  List<RecipeModel> recipeList = [];
  List<RecipeModel> selectedRecipe = [];
  int? selectedRecipeId;

  getUnit() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/unit',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        unitList = dataJSON
            .map<UnitModel>((json) => UnitModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getRecipe() async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/recipe',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        recipeList = dataJSON
            .map<RecipeModel>((json) => RecipeModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  getOneRecipe(int recipeId) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/recipe/$recipeId',
        method: HttpMethod.get,
      );

      if (response != null) {
        var dataJSON = response.data;
        selectedRecipe = dataJSON
            .map<RecipeModel>((json) => RecipeModel.fromJSON(json))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  addRecipe({
    required int productId,
    required List<IngredientModel> selectedIngredient,
  }) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      List<Map<String, dynamic>> jsonList =
          selectedIngredient.map((ingredient) => ingredient.toJSON()).toList();
      String jsonString = jsonEncode(jsonList);

      var response = await RequestService().request(
        '/recipe/$productId',
        method: HttpMethod.post,
        data: jsonString,
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'เพิ่มสูตรสำเร็จ',
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

  editRecipe({
    required int productId,
    required List<IngredientModel> selectedIngredient,
  }) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      List<Map<String, dynamic>> jsonList =
      selectedIngredient.map((ingredient) => ingredient.toJSON()).toList();
      String jsonString = jsonEncode(jsonList);

      var response = await RequestService().request(
        '/recipe/$productId',
        method: HttpMethod.patch,
        data: jsonString,
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'แก้ไขสูตรสำเร็จ',
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

  deleteRecipe(int id) async {
    bool isOnline = await RequestService().checkInternetConnection();

    if (!isOnline) {
      showAlert('ไม่มีสัญญาณอินเตอร์เน็ต');
      isLoading.value = false;

      return;
    }

    try {
      isLoading.value = true;

      var response = await RequestService().request(
        '/recipe/$id',
        method: HttpMethod.delete,
      );

      if (response != null) {
        Get.dialog(
          CustomAlertDialog(
            title: 'ลบสูตรสำเร็จ',
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
}
