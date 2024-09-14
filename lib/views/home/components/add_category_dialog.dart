// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lin_chuck/constant/value_constant.dart';
// import 'package:lin_chuck/views/home/controller/home_controller.dart';
// import 'package:lin_chuck/widget/custom_submit_button.dart';
// import 'package:lin_chuck/widget/custom_text_field.dart';
// import 'package:lin_chuck/widget/text_font_style.dart';
//
// class AddCategoryDialog extends StatefulWidget {
//   const AddCategoryDialog({super.key});
//
//   @override
//   State<AddCategoryDialog> createState() => _AddCategoryDialogState();
// }
//
// class _AddCategoryDialogState extends State<AddCategoryDialog> {
//   final HomeController _homeController = Get.find();
//   final TextEditingController _productTypeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       contentPadding: const EdgeInsets.all(marginX2),
//       content: ConstrainedBox(
//         constraints: BoxConstraints(
//           minHeight: 80.0,
//           minWidth: Get.width / 3,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const TextFontStyle(
//               'เพิ่มหมวดหมู่',
//               color: Colors.black,
//               size: fontSizeL,
//               weight: FontWeight.bold,
//             ),
//             const SizedBox(height: 20.0),
//             CustomTextField(
//               textEditingController: _productTypeController,
//               labelText: 'หมวดหมู่',
//               helperText: 'เช่น อาหารจานเดี่ยว ขนม เครื่องดื่ม',
//               maxLength: 30,
//             ),
//             const SizedBox(height: 20.0),
//             _actionButton(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _actionButton() {
//     return Row(
//       children: [
//         Expanded(
//           child: CustomSubmitButton(
//             onTap: () {
//               Get.back();
//             },
//             title: 'ยกเลิก',
//             backgroundColor: Colors.transparent,
//             showBorder: true,
//             borderColor: primaryColor,
//             fontColor: primaryColor,
//           ),
//         ),
//         const SizedBox(width: marginX2),
//         Expanded(
//           child: CustomSubmitButton(
//             onTap: () async {
//               bool? result = await _homeController
//                   .addProductType(_productTypeController.text);
//
//               if (result != null) {
//                 Get.back(result: true);
//               }
//             },
//             title: 'ยืนยัน',
//             backgroundColor: primaryColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
