import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
import 'package:lin_chuck/widget/custom_item_picker_cell.dart';
import 'package:lin_chuck/widget/custom_item_picker_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/select_camera_gallery_bottom_sheet.dart';

class AddSellProductPage extends StatefulWidget {
  final bool isFromHomePage;
  final bool isEdit;

  const AddSellProductPage({
    super.key,
    this.isFromHomePage = false,
    this.isEdit = false,
  });

  @override
  State<AddSellProductPage> createState() => _AddSellProductPageState();
}

class _AddSellProductPageState extends State<AddSellProductPage> {
  final HomeController _homeController = Get.find();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _costController = TextEditingController();

  File? _imageFile;
  String? _imageBase64;

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
        _costController.text = item?.productCost.toString() ?? '0';
        _imageBase64 = item?.productImage;
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
          ? _imageBase64 != null && _imageBase64!.length > 6
              ? Container(
                  height: 250.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade700),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.memory(
                      base64Decode(_imageBase64!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
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
        List? result = await Get.to(
          () => CustomItemPicker(
            title: 'เลือกหมวดหมู่สินค้า',
            items: _homeController.productTypeList,
            selectedItems: _homeController.selectedProductTypeList,
            itemWidget: (item, isSelected) {
              ProductTypeModel castedItem = item as ProductTypeModel;

              return CustomItemPickerCell(
                title: castedItem.name ?? '-',
                isSelected: isSelected,
              );
            },
            onSearch: (searchText) {
              if (searchText != '') {
                return _homeController.productTypeList
                    .where((productType) => productType.name!
                        .toLowerCase()
                        .contains(searchText.toLowerCase()))
                    .toList();
              } else {
                return _homeController.productTypeList;
              }
            },
            hintText: 'ค้นหาหมวดหมู่สินค้า',
            pickMultipleItem: false,
            isProductTypePage: true,
          ),
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

  _confirmAndCancelButton() {
    return Row(
      children: [
        Expanded(
          child: CustomSubmitButton(
            onTap: () {
              if (widget.isFromHomePage) {
                Get.back();
              } else {
                if (widget.isEdit) {
                  Get.back();
                  Get.back();
                } else {
                  Get.back();
                }
              }
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
                    if (_productNameController.text == '') {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณากรอกชื่อสินค้า'),
                      );
                    } else if (_homeController
                        .selectedProductTypeList.isEmpty) {
                      Get.dialog(
                        const CustomAlertDialog(
                            title: 'กรุณาเลือกหมวดหมู่สินค้า'),
                      );
                    } else if (_costController.text == '') {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณากรอกต้นทุน'),
                      );
                    } else if (_priceController.text == '') {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณากรอกราคาขาย'),
                      );
                    } else {
                      if (_imageFile != null) {
                        String base64String =
                            await _convertToBase64(_imageFile);

                        await _homeController.editProduct(
                          _homeController.selectedProductId ?? 0,
                          _productNameController.text,
                          double.parse(_priceController.text),
                          double.parse(_costController.text),
                          _homeController.selectedProductTypeList.first.id,
                          base64String,
                        );
                      } else {
                        if (_imageBase64 != null) {
                          await _homeController.editProduct(
                            _homeController.selectedProductId ?? 0,
                            _productNameController.text,
                            double.parse(_priceController.text),
                            double.parse(_costController.text),
                            _homeController.selectedProductTypeList.first.id,
                            _imageBase64,
                          );
                        } else {
                          await _homeController.editProduct(
                            _homeController.selectedProductId ?? 0,
                            _productNameController.text,
                            double.parse(_priceController.text),
                            double.parse(_costController.text),
                            _homeController.selectedProductTypeList.first.id,
                            null,
                          );
                        }
                      }
                    }

                    _homeController.selectedProductList.clear();
                  }
                : () async {
                    if (_productNameController.text == '') {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณากรอกชื่อสินค้า'),
                      );
                    } else if (_homeController
                        .selectedProductTypeList.isEmpty) {
                      Get.dialog(
                        const CustomAlertDialog(
                            title: 'กรุณาเลือกหมวดหมู่สินค้า'),
                      );
                    } else if (_costController.text == '') {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณากรอกต้นทุน'),
                      );
                    } else if (_priceController.text == '') {
                      Get.dialog(
                        const CustomAlertDialog(title: 'กรุณากรอกราคาขาย'),
                      );
                    } else {
                      if (_imageFile != null) {
                        String base64String =
                            await _convertToBase64(_imageFile);

                        await _homeController.addProduct(
                          _productNameController.text,
                          double.parse(_priceController.text),
                          double.parse(_costController.text),
                          base64String,
                          _homeController.selectedProductTypeList.first.id,
                        );
                      } else {
                        await _homeController.addProduct(
                          _productNameController.text,
                          double.parse(_priceController.text),
                          double.parse(_costController.text),
                          null,
                          _homeController.selectedProductTypeList.first.id,
                        );
                      }
                    }

                    _homeController.selectedProductList.clear();
                  },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }

  Future<String> _convertToBase64(File? imageFile) async {
    List<int> imageBytes = await imageFile!.readAsBytes();
    String base64String = base64Encode(imageBytes);

    return base64String;
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
