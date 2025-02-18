import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/recipe/componenets/add_ingredient_dialog.dart';
import 'package:lin_chuck/views/recipe/controller/recipe_controller.dart';
import 'package:lin_chuck/views/recipe/model/ingredient_model.dart';
import 'package:lin_chuck/views/recipe/model/recipe_model.dart';
import 'package:lin_chuck/views/stock/controller/stock_controller.dart';
import 'package:lin_chuck/views/stock/model/stock_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
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
  final StockController _stockController = Get.find();
  final RecipeController _recipeController = Get.find();
  final TextEditingController _sellProductController = TextEditingController();

  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    if (widget.isEdit && _recipeController.selectedRecipeId != null) {
      await _recipeController.getOneRecipe(_recipeController.selectedRecipeId!);

      RecipeModel? item = _recipeController.selectedRecipe.first;

      for (ProductModel product in _homeController.productList) {
        if (item.productId == product.id) {
          _homeController.selectedProductList.add(product);
        }
      }

      _sellProductController.text = item.productName ?? '';

      for (RecipeModel? recipe in _recipeController.selectedRecipe) {
        for (StockModel ingredient in _stockController.stockList) {
          if (ingredient.ingredientsId == recipe?.ingredientId) {
            if (recipe != null) {
              StockModel stock = StockModel(
                ingredientsId: ingredient.ingredientsId,
                ingredientType: ingredient.ingredientType,
                ingredientName: ingredient.ingredientName,
                unitId: ingredient.unitId,
                unitName: ingredient.unitName,
                orderAmount: ingredient.orderAmount,
                remain: ingredient.remain,
                lotNumber: ingredient.lotNumber,
                orderDate: ingredient.orderDate,
                expireDate: ingredient.expireDate,
                recipeQty: recipe.amount ?? 1,
              );

              _stockController.selectedStockList.add(stock);
            }
          }
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'เพิ่มสูตร',
          bottomPadding: _sellProductController.text == '' &&
                  _focusNode?.hasFocus != null &&
                  !_focusNode!.hasFocus
              ? 30.0
              : 20.0,
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
              SizedBox(
                  height: _sellProductController.text == '' &&
                          _focusNode?.hasFocus != null &&
                          !_focusNode!.hasFocus
                      ? 0.0
                      : 10.0),
              _selectedProduct(),
              const SizedBox(height: marginX2),
              _selectIngredientButton(),
              const SizedBox(height: 20.0),
              _stockController.selectedStockList.isNotEmpty
                  ? const TextFontStyle(
                      'วัตถุดิบที่เลือก',
                      size: fontSizeM,
                      weight: FontWeight.bold,
                    )
                  : const SizedBox(),
              const SizedBox(height: marginX2),
              _selectedIngredientList(),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  _selectedProduct() {
    return InkWell(
      onTap: () async {
        List? result = await Get.to(
          () => CustomItemPicker(
            title: 'เลือกสินค้า',
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
            hintText: 'ค้นหาสินค้า',
            pickMultipleItem: false,
          ),
        );

        if (result != null) {
          _sellProductController.text =
              _homeController.selectedProductList.first.name ?? '';
          setState(() {});
        }
      },
      child: CustomTextField(
        isEnabled: false,
        textEditingController: _sellProductController,
        focusNode: _focusNode,
        labelText: 'สินค้า',
      ),
    );
  }

  _selectIngredientButton() {
    return InkWell(
      onTap: () async {
        List? result = await Get.to(
          () => CustomItemPicker(
            isIngredientPage: true,
            title: 'เลือกวัตถุดิบ',
            items: _stockController.stockList,
            selectedItems: _stockController.selectedStockList,
            itemWidget: (item, isSelected) {
              StockModel castedItem = item as StockModel;

              return CustomItemPickerCell(
                title: castedItem.ingredientName ?? '-',
                isSelected: isSelected,
              );
            },
            onSearch: (searchText) {
              if (searchText != '') {
                return _stockController.stockList
                    .where((stock) => stock.ingredientName!
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    .toList();
              } else {
                return _stockController.stockList;
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
        height: 60.0,
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
              size: 30.0,
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
      itemCount: _stockController.selectedStockList.length,
      itemBuilder: (context, index) {
        StockModel item = _stockController.selectedStockList[index];

        return _ingredientRow(
            index: index + 1,
            title: item.ingredientName ?? '-',
            amount: item.recipeQty,
            unit: item.unitName ?? '-',
            onAdd: () async {
              int? result = await Get.dialog(
                AddIngredientDialog(qty: item.recipeQty),
              );
              if (result != null && result != 0) {
                item.recipeQty = result;
                setState(() {});
              }
            },
            onDelete: () {
              _stockController.selectedStockList.removeAt(index);
              setState(() {});
            });
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: marginX2);
      },
    );
  }

  _ingredientRow({
    required int index,
    required String title,
    required int amount,
    required String unit,
    required Function() onAdd,
    required Function() onDelete,
  }) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60.0,
            padding: const EdgeInsets.symmetric(horizontal: marginX2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFontStyle(
                    '$index. $title',
                    size: fontSizeM,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: onAdd,
                        child: Container(
                          width: 100.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Center(
                            child: TextFontStyle(
                              amount.toString(),
                              size: fontSizeM,
                            ),
                          ),
                        ),
                      ),
                      //TODO: clear พวกcontrollerในitempicker
                      const SizedBox(width: marginX2),
                      TextFontStyle(
                        unit,
                        size: fontSizeM,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: marginX2),
        InkWell(
          onTap: onDelete,
          child: const Icon(
            Icons.remove_circle_outline_rounded,
            color: Colors.red,
            size: 30.0,
          ),
        ),
      ],
    );
  }

  _confirmAndCancelButton() {
    return Row(
      children: [
        Expanded(
          child: CustomSubmitButton(
            onTap: widget.isEdit
                ? () {
                    _homeController.selectedProductList.clear();
                    _stockController.selectedStockList.clear();

                    Get.back();
                    Get.back();
                  }
                : () {
                    _homeController.selectedProductList.clear();
                    _stockController.selectedStockList.clear();

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
            onTap: widget.isEdit
                ? () async {
                    if (_homeController.selectedProductList.isEmpty) {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณาเลือกสินค้า'),
                      );
                    } else if (_stockController.selectedStockList.isEmpty) {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณาเลือกวัตถุดิบ'),
                      );
                    } else {
                      List<IngredientModel> ingredientList = [];
                      for (StockModel ingredient
                          in _stockController.selectedStockList) {
                        IngredientModel selectedIngredient = IngredientModel(
                          productId:
                              _homeController.selectedProductList.first.id,
                          productName:
                              _homeController.selectedProductList.first.name,
                          ingredientId: ingredient.ingredientsId,
                          ingredientName: ingredient.ingredientName,
                          amount: ingredient.recipeQty,
                          unitId: ingredient.unitId,
                          unit: ingredient.unitName,
                        );

                        ingredientList.add(selectedIngredient);
                      }

                      await _recipeController.editRecipe(
                        productId:
                            _homeController.selectedProductList.first.id ?? 0,
                        selectedIngredient: ingredientList,
                      );
                    }
                  }
                : () async {
                    if (_homeController.selectedProductList.isEmpty) {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณาเลือกสินค้า'),
                      );
                    } else if (_stockController.selectedStockList.isEmpty) {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณาเลือกวัตถุดิบ'),
                      );
                    } else {
                      List<IngredientModel> ingredientList = [];
                      for (StockModel ingredient
                          in _stockController.selectedStockList) {
                        IngredientModel selectedIngredient = IngredientModel(
                          productId:
                              _homeController.selectedProductList.first.id,
                          productName:
                              _homeController.selectedProductList.first.name,
                          ingredientId: ingredient.ingredientsId,
                          ingredientName: ingredient.ingredientName,
                          amount: ingredient.recipeQty,
                          unitId: ingredient.unitId,
                          unit: ingredient.unitName,
                        );

                        ingredientList.add(selectedIngredient);
                      }

                      await _recipeController.addRecipe(
                        productId:
                            _homeController.selectedProductList.first.id ?? 0,
                        selectedIngredient: ingredientList,
                      );
                    }
                  },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }

  _validate() {
    if (_homeController.selectedProductList.isEmpty) {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณาเลือกสินค้า'),
      );
    } else if (_stockController.selectedStockList.isEmpty) {
      Get.dialog(
        const CustomAlertDialog(title: 'กรุณาเลือกวัตถุดิบ'),
      );
    }
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
