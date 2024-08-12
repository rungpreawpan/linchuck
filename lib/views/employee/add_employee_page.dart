import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/components/add_employee_dialog.dart';
import 'package:lin_chuck/widget/custom_app_bar.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/widget/custom_side_bar.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  int employeeNo = 1;
  int employeeListPage = 1;
  int currentPage = 1;

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const CustomAppBar(title: 'เพิ่มพนักงาน'),
                _employeeList(),
                const SizedBox(height: 20.0),
                _page(),
                const SizedBox(height: 20.0),
                _confirmAndCancelButton(),
              ],
            ),
          ),
          const SizedBox(width: 30.0),
        ],
      ),
    );
  }

  _employeeList() {
    return Expanded(
      child: ListView.separated(
        itemCount: employeeNo,
        itemBuilder: (context, index) {
          TextEditingController firstnameController$index =
              TextEditingController();
          TextEditingController lastnameController$index =
              TextEditingController();

          if (index + 1 == employeeNo) {
            return Column(
              children: [
                _employeeData(
                  index: int.parse((index + 1).toString()),
                  firstnameController: firstnameController$index,
                  lastnameController: lastnameController$index,
                  deleteEmployee: () {
                    if (employeeNo != 1) {
                      employeeNo -= 1;

                      if (employeeNo % 6 == 0) {
                        employeeListPage -= 1;
                      }
                    }

                    setState(() {});
                    print(employeeNo);
                    print(employeeListPage);
                  },
                ),
                const SizedBox(height: marginX2),
                _addEmployeeButton(),
              ],
            );
          } else {
            return _employeeData(
              index: int.parse((index + 1).toString()),
              firstnameController: firstnameController$index,
              lastnameController: lastnameController$index,
              deleteEmployee: () {
                if (employeeNo != 1) {
                  employeeNo -= 1;

                  if (employeeNo % 6 == 0) {
                    employeeListPage -= 1;
                  }
                }

                setState(() {});
                print(employeeNo);
                print(employeeListPage);
              },
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: marginX2);
        },
      ),
    );
  }

  _employeeData({
    required int index,
    required TextEditingController firstnameController,
    required TextEditingController lastnameController,
    required Function() deleteEmployee,
  }) {
    return Row(
      children: [
        TextFontStyle(
          '${index.toString()}.',
          size: fontSizeL,
        ),
        const SizedBox(width: marginX2),
        Expanded(
          flex: 1,
          child: CustomTextField(
            textEditingController: firstnameController,
            labelText: 'ชื่อ',
          ),
        ),
        const SizedBox(width: marginX2),
        Expanded(
          flex: 1,
          child: CustomTextField(
            textEditingController: lastnameController,
            labelText: 'นามสกุล',
          ),
        ),
        const SizedBox(width: marginX2),
        InkWell(
          onTap: deleteEmployee,
          child: const Icon(
            Icons.delete_outline_rounded,
            color: primaryColor,
            size: fontSizeXL,
          ),
        ),
      ],
    );
  }

  _addEmployeeButton() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            employeeNo += 1;

            if (employeeNo % 6 == 1) {
              employeeListPage += 1;
            }

            setState(() {});
            print(employeeNo);
            print(employeeListPage);
          },
          child: const Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: primaryColor,
                size: fontSizeL,
              ),
              SizedBox(width: margin),
              TextFontStyle(
                'เพิ่มพนักงาน',
                size: fontSizeM,
                weight: FontWeight.bold,
                color: primaryColor,
              ),
            ],
          ),
        ),
        const TextFontStyle(
          ' หรือ ',
          size: fontSizeM,
          weight: FontWeight.bold,
        ),
        InkWell(
          onTap: () {
            Get.dialog(const AddEmployeeDialog());
          },
          child: const TextFontStyle(
            'เพิ่มเป็นจำนวนมาก',
            size: fontSizeM,
            weight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  _page() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: currentPage != 1 ? () {} : null,
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: currentPage != 1 ? Colors.black : Colors.grey.shade300,
          ),
        ),
        const SizedBox(width: 20.0),
        const TextFontStyle(
          '1',
          size: fontSizeM,
        ),
        const SizedBox(width: 20.0),
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            // color: Colors.grey,
          ),
        ),
      ],
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
            showBorder: true,
            borderColor: primaryColor,
            backgroundColor: Colors.transparent,
            fontColor: primaryColor,
          ),
        ),
        const SizedBox(width: marginX2),
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
