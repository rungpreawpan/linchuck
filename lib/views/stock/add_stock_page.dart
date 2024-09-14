import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/select_category_dialog.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/select_camera_gallery_bottom_sheet.dart';

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
  final HomeController _homeController = Get.find();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _orderDateController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();

  DateTime? _selectedOrderDate;
  DateTime? _selectedExpireDate;

  File? _imageFile;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _homeController.getProductType();

    if (widget.isEdit && _homeController.selectedProductId != null) {
      await _homeController.getOneProduct(_homeController.selectedProductId!);

      if (_homeController.selectedProduct != null) {
        ProductModel? item = _homeController.selectedProduct;
        String? productTypeName;

        for (ProductTypeModel type in _homeController.productTypeList) {
          if (type.id == item?.productTypeId) {
            productTypeName = type.name ?? '';
          }
        }

        _productNameController.text = item?.name ?? '-';
        _productTypeController.text = productTypeName ?? '-';
        _priceController.text = item?.productPrice.toString() ?? '0';
        _quantityController.text = item?.quantity.toString() ?? '0';
        _costController.text = item?.productCost.toString() ?? '0';
        _orderDateController.text = DateFormat('dd/MM/yyyy').format(
            DateTime.parse(item?.orderDate ?? DateTime.now().toString()));
        _expireDateController.text = DateFormat('dd/MM/yyyy').format(
            DateTime.parse(item?.expireDate ?? DateTime.now().toString()));
      }
    }

    setState(() {});
  }

  Future getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    }

    setState(() {});
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'เพิ่มสินค้า',
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                _image(),
                const SizedBox(width: 30.0),
                Expanded(
                  child: Column(
                    children: [
                      _productName(),
                      const SizedBox(height: margin),
                      _productType(),
                      const SizedBox(height: 20.0),
                      _quantity(),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          Expanded(
                            child: _productCost(),
                          ),
                          const SizedBox(width: marginX2),
                          Expanded(
                            child: _productPrice(),
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
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100.0),
            _confirmAndCancelButton(),
          ],
        ),
      ),
    );
  }

  _image() {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          SelectCameraGalleryBottomSheet(
            getImageFromCamera: getImageFromCamera,
            getImageFromGallery: getImageFromGallery,
          ),
        );
      },
      child: _imageFile == null
          ? Container(
              height: 250.0,
              width: 400.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade700),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.grey.shade700,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade700),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.file(
                  _imageFile!,
                  height: 250.0,
                  width: 400.0,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
    );
  }

  _productName() {
    return CustomTextField(
      textEditingController: _productNameController,
      labelText: 'ชื่อสินค้า',
      maxLength: 30,
    );
  }

  _productPrice() {
    return CustomTextField(
      textEditingController: _priceController,
      labelText: 'ราคาขาย',
      inputType: TextInputType.number,
    );
  }

  _productCost() {
    return CustomTextField(
      textEditingController: _costController,
      labelText: 'ต้นทุน',
      inputType: TextInputType.number,
    );
  }

  _productType() {
    return InkWell(
      onTap: () async {
        bool? result = await Get.dialog(
          const SelectCategoryDialog(),
          barrierDismissible: false,
        );

        if (result != null) {
          _productTypeController.text =
              _homeController.selectedProductTypeList.first.name ?? '';

          setState(() {});
        }
      },
      child: CustomTextField(
        isEnabled: false,
        textEditingController: _productTypeController,
        labelText: 'หมวดหมู่',
      ),
    );
  }

  _quantity() {
    return CustomTextField(
      textEditingController: _quantityController,
      labelText: 'จำนวน',
      inputType: TextInputType.number,
    );
  }

  _orderDate() {
    return InkWell(
      onTap: () async {
        _selectedOrderDate = await _datePicker();

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
        _selectedExpireDate = await _datePicker();

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
            onTap: () {
              Get.back();
            },
            title: 'ยกเลิก',
            fontColor: Colors.black,
            showBorder: true,
            borderColor: Colors.black,
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: CustomSubmitButton(
            onTap: widget.isEdit
                ? () async {
                    await _homeController.editProduct(
                      _homeController.selectedProductId ?? 0,
                      _productNameController.text,
                      double.parse(_priceController.text),
                      double.parse(_costController.text),
                      int.parse(_quantityController.text),
                      _homeController.selectedProductTypeList.first.id,
                      _selectedOrderDate.toString(),
                      _selectedExpireDate.toString(),
                    );
                  }
                : () async {
                    await _homeController.addProduct(
                      _productNameController.text,
                      double.parse(_priceController.text),
                      double.parse(_costController.text),
                      int.parse(_quantityController.text),
                      _homeController.selectedProductTypeList.first.id,
                      _selectedOrderDate.toString(),
                      _selectedExpireDate.toString(),
                    );
                  },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }

  _datePicker() {
    return showDatePicker(
      context: context,
      locale: const Locale('th', 'TH'),
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      confirmText: 'ยืนยัน',
      cancelText: 'ยกเลิก',
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _homeController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
