import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/select_camera_gallery_bottom_sheet.dart';

class AddStockPage extends StatefulWidget {
  const AddStockPage({super.key});

  @override
  State<AddStockPage> createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _orderDateController = TextEditingController();
  final TextEditingController _expireDateController = TextEditingController();

  File? _imageFile;

  Future getImageFromGallery() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      //TODO: แก้appbartitle
      appBarTitle: 'เพิ่มสินค้า',
      contentWidget: [
        _content(),
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
                      _productPrice(),
                      const SizedBox(height: 20.0),
                      _orderDate(),
                      const SizedBox(height: 20.0),
                      _expireDate(),
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
      labelText: 'ราคา',
      inputType: TextInputType.number,
    );
  }

  _orderDate() {
    return CustomTextField(
      textEditingController: _priceController,
      labelText: 'วันสั่งซื้อ',
      inputType: TextInputType.number,
    );
  }

  _expireDate() {
    return CustomTextField(
      textEditingController: _priceController,
      labelText: 'วันหมดอายุ',
      inputType: TextInputType.number,
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
            onTap: () {},
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }
}
