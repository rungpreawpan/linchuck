import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/recipe/controller/recipe_controller.dart';
import 'package:lin_chuck/views/recipe/model/unit_model.dart';
import 'package:lin_chuck/views/stock/controller/stock_controller.dart';
import 'package:lin_chuck/views/stock/model/stock_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
import 'package:lin_chuck/widget/custom_item_picker_cell.dart';
import 'package:lin_chuck/widget/custom_item_picker_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_select_date.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';

class AddStockPage extends StatefulWidget {
  final bool isEdit;

  const AddStockPage({
    super.key,
    this.isEdit = false,
  });

  @override
  State<AddStockPage> createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final StockController _stockController = Get.find();
  final RecipeController _recipeController = Get.find();

  final TextEditingController _ingredientNameController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _lotNoController = TextEditingController();
  final TextEditingController _orderDateController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();

  DateTime? _selectedOrderDate;
  DateTime? _selectedExpireDate;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _recipeController.getUnit();

    if (widget.isEdit && _stockController.selectedStockId != null) {
      await _stockController
          .getOneIngredient(_stockController.selectedStockId!);

      if (_stockController.selectedStock != null) {
        StockModel? item = _stockController.selectedStock;

        for (UnitModel unit in _recipeController.unitList) {
          if (item?.unitName == unit.unitName) {
            _recipeController.selectedUnit.add(unit);
          }
        }

        _ingredientNameController.text = item?.ingredientName ?? '';
        _lotNoController.text = item?.lotNumber ?? '';
        _quantityController.text =
            item?.orderAmount != null ? item!.orderAmount.toString() : '0';
        _unitController.text = item?.unitName ?? '';
        _orderDateController.text = item?.orderDate != null
            ? DateFormat('dd/MM/yyyy').format(DateTime.parse(item!.orderDate!))
            : '';
        _expireDateController.text = item?.expireDate != null
            ? DateFormat('dd/MM/yyyy').format(DateTime.parse(item!.expireDate!))
            : '';
        _selectedOrderDate =
            item?.orderDate != null ? DateTime.parse(item!.orderDate!) : null;
        _selectedExpireDate =
            item?.expireDate != null ? DateTime.parse(item!.expireDate!) : null;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'เพิ่มวัตถุดิบ',
          contentWidget: [
            _content(),
          ],
        ),
        _loading(),
      ],
    );
  }

  _content() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ingredientName(),
              const SizedBox(height: margin),
              _lotNumber(),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: _quantity(),
                  ),
                  const SizedBox(width: marginX2),
                  Expanded(
                    child: _unit(),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: _orderDate(),
                  ),
                  const SizedBox(width: marginX2),
                  Expanded(
                    child: _expireDate(),
                  ),
                ],
              ),
              const SizedBox(height: 100.0),
              _confirmAndCancelButton(),
            ],
          ),
        ),
      ),
    );
  }

  _ingredientName() {
    return CustomTextField(
      textEditingController: _ingredientNameController,
      labelText: 'ชื่อวัตถุดิบ',
      maxLength: 30,
    );
  }

  _quantity() {
    return CustomTextField(
      textEditingController: _quantityController,
      labelText: 'จำนวน',
      inputType: TextInputType.number,
    );
  }

  _unit() {
    return InkWell(
      onTap: () async {
        List? result = await Get.to(
          () => CustomItemPicker(
            title: 'หน่วย',
            items: _recipeController.unitList,
            selectedItems: _recipeController.selectedUnit,
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
          _unitController.text =
              _recipeController.selectedUnit.first.unitName ?? '';
          setState(() {});
        }
      },
      child: CustomTextField(
        isEnabled: false,
        textEditingController: _unitController,
        labelText: 'หน่วย',
      ),
    );
  }

  _lotNumber() {
    return CustomTextField(
      textEditingController: _lotNoController,
      labelText: 'Lot No.',
    );
  }

  _orderDate() {
    return InkWell(
      onTap: () async {
        _selectedOrderDate = await datePicker(context);

        if (_selectedOrderDate != null) {
          _orderDateController.text =
              DateFormat('dd/MM/yyyy').format(_selectedOrderDate!);

          setState(() {});
        }
      },
      child: CustomTextField(
        isEnabled: false,
        textEditingController: _orderDateController,
        labelText: 'วันสั่งซื้อ',
        inputType: TextInputType.number,
        suffix: const Icon(Icons.calendar_month_rounded),
      ),
    );
  }

  _expireDate() {
    return InkWell(
      onTap: () async {
        _selectedExpireDate = await datePicker(context);

        if (_selectedExpireDate != null) {
          _expireDateController.text =
              DateFormat('dd/MM/yyyy').format(_selectedExpireDate!);

          setState(() {});
        }
      },
      child: CustomTextField(
        isEnabled: false,
        textEditingController: _expireDateController,
        labelText: 'วันหมดอายุ',
        inputType: TextInputType.number,
        suffix: const Icon(Icons.calendar_month_rounded),
      ),
    );
  }

  _confirmAndCancelButton() {
    return Row(
      children: [
        Expanded(
          child: CustomSubmitButton(
            onTap: widget.isEdit
                ? () {
                    Get.back();
                    Get.back();
                  }
                : () {
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
            onTap: () async {
              if (_ingredientNameController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณากรอกชื่อวัตถุดิบ'),
                );
              } else if (_lotNoController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณากรอก Lot No.'),
                );
              } else if (_quantityController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณากรอกจำนวน'),
                );
              } else if (_unitController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณาเลือกหน่วย'),
                );
              } else if (_orderDateController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณาเลือกวันที่สั่งซื้อ'),
                );
              } else if (_expireDateController.text == '') {
                Get.dialog(
                  const CustomAlertDialog(title: 'กรุณาเลือกวันที่หมดอายุ'),
                );
              } else {
                if (widget.isEdit) {
                  await _stockController.editIngredient(
                    id: _stockController.selectedStockId ?? 0,
                    ingredientName: _ingredientNameController.text,
                    unitId: _recipeController.selectedUnit.first.unitId ?? 0,
                    unitName:
                        _recipeController.selectedUnit.first.unitName ?? '',
                    orderAmount: int.parse(_quantityController.text),
                    lotNumber: _lotNoController.text,
                    orderDate: _selectedOrderDate.toString(),
                    expireDate: _selectedExpireDate.toString(),
                  );
                } else {
                  await _stockController.addIngredient(
                    ingredientName: _ingredientNameController.text,
                    unitId: _recipeController.selectedUnit.first.unitId ?? 0,
                    unitName:
                        _recipeController.selectedUnit.first.unitName ?? '',
                    orderAmount: int.parse(_quantityController.text),
                    lotNumber: _lotNoController.text,
                    orderDate: _selectedOrderDate.toString(),
                    expireDate: _selectedExpireDate.toString(),
                  );
                }
              }
            },
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
        visible: _stockController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
