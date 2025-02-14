import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/delete_dialog.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/recipe/add_recipe_page.dart';
import 'package:lin_chuck/views/recipe/controller/recipe_controller.dart';
import 'package:lin_chuck/views/recipe/model/recipe_model.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/edit_delete_popup.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final HomeController _homeController = Get.find();
  final RecipeController _recipeController = Get.find();

  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _recipeController.getUnit();
    await _recipeController.getRecipe();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'สูตรทั้งหมด',
          contentWidget: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _addRecipeButton(),
                    ],
                  ),
                  const SizedBox(height: marginX2),
                  _recipeList(),
                ],
              ),
            ),
          ],
          showActionButton: true,
          actionButton: InkWell(
            onTap: () async {
              await _prepareData();
            },
            child: const Icon(
              Icons.refresh_rounded,
              color: primaryColor,
            ),
          ),
        ),
        _loading(),
      ],
    );
  }

  _addRecipeButton() {
    return InkWell(
      onTap: () {
        _homeController.selectedProductList.clear();

        Get.to(() => const AddRecipePage());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: const Center(
          child: TextFontStyle(
            'เพิ่มสูตร',
            color: Colors.white,
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _recipeList() {
    return Expanded(
      child: Column(
        children: [
          _recipeRow(
            isHeader: true,
            index: 0,
            title0: 'สูตร',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: _recipeController.recipeList
                  .map((e) => e.productId)
                  .toSet()
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                RecipeModel item = _recipeController.recipeList[index];

                return _recipeRow(
                  index: item.productId ?? 0,
                  title0: item.productName ?? '',
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  _recipeRow({
    bool isHeader = false,
    required int index,
    required String title0,
  }) {
    return Padding(
      padding: isHeader
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextFontStyle(
              title0,
              size: isHeader ? fontSizeL : fontSizeM,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 20.0),
          isHeader
              ? const Icon(
                  Icons.more_vert_rounded,
                  size: fontSizeL,
                  color: Colors.white,
                )
              : EditDeletePopup(
                  selectedItem: selectedItem,
                  onEdit: () async {
                    _recipeController.selectedRecipeId = index;

                    bool? result =
                        await Get.to(() => const AddRecipePage(isEdit: true));

                    if (result != null) {
                      await _recipeController.getRecipe();

                      setState(() {});
                    }
                  },
                  onDelete: () async {
                    _recipeController.selectedRecipeId = index;
                    bool? result = await Get.dialog(const DeleteDialog());

                    if (result != null) {
                      await _recipeController.deleteRecipe(
                          _recipeController.selectedRecipeId ?? 0);
                      Get.back();

                      await _recipeController.getRecipe();
                      Get.back();
                      setState(() {});
                    }
                  },
                ),
        ],
      ),
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
