import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/views/recipe/controller/recipe_controller.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/main_template.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final RecipeController _recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: '',
          contentWidget: [],
        ),
        _loading(),
      ],
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _recipeController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
