import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/select_category_dialog.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/select_camera_gallery_bottom_sheet.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class EditMenuDialog extends StatefulWidget {
  const EditMenuDialog({super.key});

  @override
  State<EditMenuDialog> createState() => _EditMenuDialogState();
}

class _EditMenuDialogState extends State<EditMenuDialog> {
  final HomeController _homeController = Get.find();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

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

  // bool _showKeyboard = true;

  @override
  void initState() {
    super.initState();

    // _prepareData();
  }

  // _prepareData() async {
  //   await _homeController.getOptions();
  //
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.all(marginX2),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 80.0,
          minWidth: Get.width / 2,
          maxWidth: Get.width / 2,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextFontStyle(
                'แก้ไขสินค้า',
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _image(),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      children: [
                        _productName(),
                        const SizedBox(height: 4.0),
                        _selectCategory(),
                        const SizedBox(height: marginX2),
                        _productPrice(),
                        // _selectedOptionBox(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _actionButton(),
            ],
          ),
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
              height: 150.0,
              width: 200.0,
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
                  height: 150.0,
                  width: 200.0,
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

  _selectCategory() {
    return InkWell(
      onTap: () {
        Get.dialog(
          const SelectCategoryDialog(),
          barrierDismissible: false,
        );
      },
      child: CustomTextField(
        isEnabled: false,
        textEditingController: _categoryController,
        labelText: 'หมวดหมู่',
      ),
    );
  }

  _actionButton() {
    return Row(
      children: [
        Expanded(
          child: CustomSubmitButton(
            onTap: () {
              Get.back();
            },
            title: 'ยกเลิก',
            backgroundColor: Colors.transparent,
            showBorder: true,
            borderColor: primaryColor,
            fontColor: primaryColor,
          ),
        ),
        const SizedBox(width: marginX2),
        Expanded(
          child: CustomSubmitButton(
            onTap: () {
              Get.back();
            },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        )
      ],
    );
  }

// _selectedOptionBox() {
//   return _homeController.selectedOptionList.isEmpty
//       ? InkWell(
//           onTap: () {},
//           child: Container(
//             height: 50.0,
//             width: Get.width,
//             padding: const EdgeInsets.symmetric(
//               horizontal: marginX2,
//               vertical: margin,
//             ),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black12),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child: const TextFontStyle(
//               'ตัวเลือก',
//               size: fontSizeM,
//               color: Colors.grey,
//             ),
//           ),
//         )
//       : Column(
//           children: [
//             Row(
//               children: [
//                 const TextFontStyle(
//                   'ตัวเลือก',
//                   size: fontSizeM,
//                 ),
//                 const SizedBox(width: marginX2),
//                 InkWell(
//                   onTap: () {},
//                   child: const Icon(
//                     Icons.add_circle,
//                     color: Colors.green,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         );
// }
}
