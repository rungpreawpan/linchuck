import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/recipe/add_recipe_page.dart';
import 'package:lin_chuck/views/recipe/controller/recipe_controller.dart';
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
  final RecipeController _recipeController = Get.put(RecipeController());

  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _recipeController.getUnit();
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
        ),
        _loading(),
      ],
    );
  }

  _addRecipeButton() {
    return InkWell(
      onTap: () {
        // print('test');
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
            title0: 'สูตร',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return _recipeRow(title0: 'test $index');
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
                    // _employeeController.selectedEmployeeId = index;
                    //
                    // bool? result =
                    // await Get.to(() => const AddEmployeePage(isEdit: true));
                    //
                    // if (result != null) {
                    //   await _employeeController.getEmployee();
                    //
                    //   setState(() {});
                    // }
                  },
                  onDelete: () async {
                    // _employeeController.selectedEmployeeId = index;
                    // await _employeeController
                    //     .deleteEmployee(_employeeController.selectedEmployeeId ?? 0);
                    // Get.back();
                    //
                    // await _employeeController.getEmployee();
                    // Get.back();
                    // setState(() {});
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
