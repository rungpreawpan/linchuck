import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/receipt.dart';
import 'package:lin_chuck/widget/custom_app_bar.dart';

// import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/widget/custom_side_bar.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/select_camera_gallery_bottom_sheet.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class SummaryOrderPage extends StatefulWidget {
  final double total;

  const SummaryOrderPage({
    super.key,
    required this.total,
  });

  @override
  State<SummaryOrderPage> createState() => _SummaryOrderPageState();
}

class _SummaryOrderPageState extends State<SummaryOrderPage> {
  // final HomeController _homeController = Get.find();
  final TextEditingController _receivedController = TextEditingController();
  final TextEditingController _changeController = TextEditingController();

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool payByCash = true;

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
    return Scaffold(
      key: _drawerKey,
      drawer: const CustomDrawer(),
      body: _content(),
    );
  }

  _content() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          top: 20.0,
          bottom: 20.0,
        ),
        child: Row(
          children: [
            CustomSideBar(
              onTap: () {
                _drawerKey.currentState!.openDrawer();
              },
            ),
            _mainContent(),
          ],
        ),
      ),
    );
  }

  _mainContent() {
    return Expanded(
      child: Column(
        children: [
          const CustomAppBar(
            showBackIcon: true,
            title: 'ชำระเงิน',
          ),
          Expanded(
            child: Row(
              children: [
                _paymentContent(),
                const SizedBox(width: marginX2),
                const Receipt(isSummaryPage: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _paymentContent() {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _paymentTypeButton(
                icon: Icons.money,
                isSelected: payByCash,
              ),
              _paymentTypeButton(
                icon: Icons.credit_card,
                isSelected: !payByCash,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Visibility(
            visible: payByCash,
            child: _cashContent(),
          ),
          Visibility(
            visible: !payByCash,
            child: _promptPayContent(),
          ),
        ],
      ),
    );
  }

  _cashContent() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(marginX2),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextFontStyle(
                'ยอดรวม',
                size: fontSizeM,
                color: Colors.grey,
              ),
              TextFontStyle(
                widget.total.toString(),
                size: 50.0,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                textEditingController: _receivedController,
                labelText: 'เงินที่ได้รับ',
                inputType: TextInputType.number,
                onChanged: (value) {
                  print(value);
                  if (value != '' && double.parse(value) > widget.total) {
                    double total = widget.total;
                    double received = double.parse(value);

                    double change = received - total;
                    _changeController.text = change.toString();
                  } else {
                    _changeController.text = '0';
                  }
                },
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                isEnabled: false,
                textEditingController: _changeController,
                labelText: 'เงินทอน',
                inputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _promptPayContent() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(marginX2),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.bottomSheet(
                    SelectCameraGalleryBottomSheet(
                      getImageFromCamera: getImageFromCamera,
                      getImageFromGallery: getImageFromGallery,
                    ),
                  );
                },
                child: Container(
                  height: 400.0,
                  width: 300.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: _imageFile != null
                      ? Image.file(
                          _imageFile!,
                          fit: BoxFit.fitHeight,
                          height: 400.0,
                          width: 300.0,
                        )
                      : const Center(
                          child: Icon(Icons.add),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _paymentTypeButton({
    required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        payByCash = !payByCash;
        setState(() {});
      },
      child: Container(
        width: 200.0,
        height: 120.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? primaryColor : Colors.black,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(icon),
      ),
    );
  }
}
