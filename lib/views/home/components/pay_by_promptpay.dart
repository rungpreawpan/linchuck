import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class PayByPromptPay extends StatefulWidget {
  const PayByPromptPay({super.key});

  @override
  State<PayByPromptPay> createState() => _PayByPromptPayState();
}

class _PayByPromptPayState extends State<PayByPromptPay> {
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
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(212, 220, 233, 1),
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: _imageFile != null
              ? _promptPayImage()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextFontStyle(
                      'กรุณาบันทึกใบเสร็จ PromptPay',
                      color: primaryColor,
                      size: 40.0,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20.0),
                    const Icon(
                      Icons.camera_alt_outlined,
                      size: 120.0,
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: CustomSubmitButton(
                        //TODO: change to camera(gallery for test only) getImageFromCamera,
                        onTap: getImageFromGallery,
                        title: 'กดเพื่อเปิดกล้อง',
                        backgroundColor: primaryColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  _promptPayImage() {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Image.file(
          _imageFile!,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: -12,
          right: -12,
          child: InkWell(
            onTap: () {
              _imageFile = null;

              setState(() {});
            },
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: customBoxShadow,
              ),
              child: const Icon(Icons.close),
            ),
          ),
        ),
      ],
    );
  }
}
