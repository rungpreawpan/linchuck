import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/add_employee_page.dart';
import 'package:lin_chuck/widget/custom_app_bar.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/widget/custom_side_bar.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
          const CustomAppBar(title: 'พนักงานทั้งหมด'),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _addEmployeeButton(),
                        ],
                      ),
                      const SizedBox(height: marginX2),
                      _employeeList(),
                    ],
                  ),
                ),
                const SizedBox(width: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _addEmployeeButton() {
    return InkWell(
      onTap: () {
        Get.to(() => const AddEmployeePage());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: const Center(
          child: TextFontStyle(
            'เพิ่มพนักงาน',
            color: Colors.white,
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _employeeList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _employeeRow(
            isHeader: true,
            title1: 'สถานะ',
            title2: 'ชื่อ',
            title3: 'นามสกุล',
            title4: 'รหัส',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              itemBuilder: (context, index) {
                return _employeeRow(
                  title1: 'ลงทะเบียนแล้ว',
                  title2: 'จอห์น',
                  title3: 'โดว์',
                  title4: '123456',
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }

  _employeeRow({
    bool isHeader = false,
    required String title1,
    required String title2,
    required String title3,
    required String title4,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFontStyle(
            title1,
            size: isHeader ? fontSizeL : fontSizeM,
            weight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader
                ? Colors.black
                : title1 == 'ลงทะเบียนแล้ว'
                    ? Colors.green
                    : Colors.red,
          ),
        ),
        Expanded(
          child: TextFontStyle(
            title2,
            size: isHeader ? fontSizeL : fontSizeM,
            weight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Expanded(
          child: TextFontStyle(
            title3,
            size: isHeader ? fontSizeL : fontSizeM,
            weight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFontStyle(
                title4,
                size: isHeader ? fontSizeL : fontSizeM,
                weight: isHeader ? FontWeight.bold : FontWeight.normal,
              ),
              Visibility(
                visible: !isHeader,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: marginX2),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(text: '$title2 $title3 รหัส: $title4'),
                        );
                      },
                      child: Icon(
                        Icons.copy,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20.0),
        InkWell(
          onTap: !isHeader ? () {} : null,
          child: Icon(
            Icons.more_vert_rounded,
            size: fontSizeL,
            color: !isHeader ? Colors.black : Colors.white,
          ),
        ),
      ],
    );
  }
}
