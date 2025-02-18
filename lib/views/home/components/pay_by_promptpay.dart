import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/selected_product_model.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/select_camera_gallery_bottom_sheet.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class PayByPromptPay extends StatefulWidget {
  final UserModel? user;
  final double total;

  const PayByPromptPay({
    super.key,
    required this.user,
    required this.total,
  });

  @override
  State<PayByPromptPay> createState() => _PayByPromptPayState();
}

class _PayByPromptPayState extends State<PayByPromptPay> {
  final HomeController _homeController = Get.find();
  File? _imageFile;

  //TODO: save to controller

  Future getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);

      List<int> imageBytes = _imageFile!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      _homeController.orderDetailPayment?.payImage = base64Image;
      _homeController.orderDetailPayment?.payType = 'promptpay';

      SelectedPaymentModel payment = SelectedPaymentModel(
        user: widget.user,
        totalPrice: widget.total,
        payType: 'promptpay',
        payImage: base64Image,
      );

     _homeController.orderDetailPayment = payment;
    }

    setState(() {});
  }

  Future getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);

      List<int> imageBytes = _imageFile!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      SelectedPaymentModel payment = SelectedPaymentModel(
        user: widget.user,
        totalPrice: widget.total,
        payType: 'promptpay',
        payImage: base64Image,
      );

      _homeController.orderDetailPayment = payment;
    }

    setState(() {});
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
                        onTap: () {
                          Get.bottomSheet(
                            SelectCameraGalleryBottomSheet(
                              getImageFromCamera: getImageFromCamera,
                              getImageFromGallery: getImageFromGallery,
                            ),
                          );
                        },
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
