import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/recipe/controller/recipe_controller.dart';
import 'package:lin_chuck/views/recipe/model/unit_model.dart';
import 'package:lin_chuck/widget/custom_item_picker_cell.dart';
import 'package:lin_chuck/widget/custom_item_picker_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddRecipePage extends StatefulWidget {
  final bool isEdit;

  const AddRecipePage({
    super.key,
    this.isEdit = false,
  });

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final HomeController _homeController = Get.find();
  final RecipeController _recipeController = Get.find();
  final TextEditingController _recipeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'เพิ่มสูตร',
          contentWidget: [
            Expanded(
              child: Column(
                children: [
                  _content(),
                  _confirmAndCancelButton(),
                ],
              ),
            ),
          ],
        ),
        _loading(),
      ],
    );
  }

  _content() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                textEditingController: _recipeNameController,
                labelText: 'ชื่อสูตร',
              ),
              const SizedBox(height: marginX2),
              _selectIngredientButton(),
              const SizedBox(height: 20.0),
              const TextFontStyle(
                'วัตถุดิบที่เลือก',
                size: fontSizeM,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: marginX2),
              _selectedIngredientList(),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  _selectIngredientButton() {
    return InkWell(
      onTap: () async {
        //TODO: change to ingredient data
        List? result = await Get.to(
          () => CustomItemPicker(
            title: 'เลือกวัตถุดิบ',
            items: _homeController.productList,
            selectedItems: _homeController.selectedProductList,
            itemWidget: (item, isSelected) {
              ProductModel castedItem = item as ProductModel;

              return CustomItemPickerCell(
                title: castedItem.name ?? '-',
                isSelected: isSelected,
              );
            },
            onSearch: (searchText) {
              if (searchText != '') {
                return _homeController.productList
                    .where((product) => product.name!
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    .toList();
              } else {
                return _homeController.productList;
              }
            },
            hintText: 'ค้นหาวัตถุดิบ',
          ),
        );

        if (result != null) {
          setState(() {});
        }
      },
      child: Container(
        height: 55.0,
        padding: const EdgeInsets.symmetric(horizontal: marginX2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFontStyle(
              'เลือกวัตถุดิบ',
              size: fontSizeM,
              color: Colors.grey,
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  _selectedIngredientList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _ingredientRow(
          index: index + 1,
          title: 'title',
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: marginX2);
      },
    );
  }

  _ingredientRow({
    required int index,
    required String title,
  }) {
    return Container(
      height: 55.0,
      padding: const EdgeInsets.symmetric(horizontal: marginX2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          TextFontStyle(
            '$index.',
            size: fontSizeM,
          ),
          TextFontStyle(
            title,
            size: fontSizeM,
          ),
          Spacer(),
          // TextFontStyle(''),
          InkWell(
            onTap: () async {
              List? result = await Get.to(
                () => CustomItemPicker(
                  title: 'หน่วย',
                  items: _recipeController.unitList,
                  selectedItems: [],
                  itemWidget: (item, isSelected) {
                    UnitModel castedItem = item as UnitModel;

                    return CustomItemPickerCell(
                      title: castedItem.unitName ?? '',
                      isSelected: isSelected,
                    );
                  },
                  onSearch: (searchText) {
                    if (searchText != '') {
                      return _recipeController.unitList
                          .where((unit) => unit.unitName!
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                          .toList();
                    } else {
                      return _recipeController.unitList;
                    }
                  },
                  hintText: 'ค้นหาหน่วย',
                  pickMultipleItem: false,
                ),
              );

              if (result != null) {
                setState(() {});
              }
            },
            child: Container(
              padding: const EdgeInsets.only(
                left: marginX2,
                right: margin,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(),
              ),
              child: const Row(
                children: [
                  TextFontStyle(
                    'เลือกหน่วย',
                    size: fontSizeM,
                  ),
                  const SizedBox(width: margin),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _confirmAndCancelButton() {
    return Row(
      children: [
        Expanded(
          child: CustomSubmitButton(
            onTap: () {
              Get.back();
            },
            title: 'ยกเลิก',
            showBorder: true,
            borderColor: primaryColor,
            backgroundColor: Colors.transparent,
            fontColor: primaryColor,
          ),
        ),
        const SizedBox(width: marginX2),
        Expanded(
          child: CustomSubmitButton(
            onTap: widget.isEdit ? () async {} : () async {},
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
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
