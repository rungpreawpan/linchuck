import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/select_camera_gallery_bottom_sheet.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class ChangeProfileImageDialog extends StatefulWidget {
  final int userId;
  final String? imageBase64;

  const ChangeProfileImageDialog({
    super.key,
    required this.userId,
    required this.imageBase64,
  });

  @override
  State<ChangeProfileImageDialog> createState() =>
      _ChangeProfileImageDialogState();
}

class _ChangeProfileImageDialogState extends State<ChangeProfileImageDialog> {
  final HomeController _homeController = Get.find();

  File? _imageFile;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFontStyle(
                'แก้ไขรูปโปรไฟล์',
                size: fontSizeL,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 30.0),
              _image(),
              const SizedBox(height: 30.0),
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
          ? widget.imageBase64 != null
              ? Container(
                  height: 250.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade700),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.memory(
                      base64Decode(widget.imageBase64!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(
                  height: 250.0,
                  width: 350.0,
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
                  width: 350.0,
                  fit: BoxFit.fitWidth,
                ),
              ),
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
            onTap: () async {
              if (_imageFile == null) {
                Get.dialog(CustomAlertDialog(title: 'กรุณาเลือกรูปภาพ'));
              } else {
                List<int> imageBytes = _imageFile!.readAsBytesSync();
                String base64Image = base64Encode(imageBytes);
                await _homeController.updateUser(widget.userId, base64Image);
              }
            },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        )
      ],
    );
  }
}
