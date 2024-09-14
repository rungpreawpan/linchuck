import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/add_employee_page.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/edit_delete_popup.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  final EmployeeController _employeeController = Get.put(EmployeeController());

  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _employeeController.getEmployee();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'พนักงานทั้งหมด',
          contentWidget: [
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
          showActionButton: true,
          actionButton: InkWell(
            onTap: () async {
              await _prepareData();
            },
            child: const Icon(
              Icons.refresh_rounded,
              color: primaryColor,
            ),
          ),
        ),
        _loading(),
      ],
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
            index: 0,
            isHeader: true,
            title0: 'ลำดับที่',
            title1: 'สถานะ',
            title2: 'ชื่อ',
            title3: 'นามสกุล',
            title4: 'รหัส',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: _employeeController.employeeList.length,
              itemBuilder: (context, index) {
                UserModel item = _employeeController.employeeList[index];
                bool isRegister = false;

                if (item.email != '' && item.password != '') {
                  isRegister = true;
                } else {
                  isRegister = false;
                }

                return _employeeRow(
                  index: item.id ?? 0,
                  title0: (index + 1).toString(),
                  title1: isRegister ? 'ลงทะเบียนแล้ว' : 'ยังไม่ได้ลงทะเบียน',
                  title2: item.firstname ?? '',
                  title3: item.lastname ?? '',
                  title4: item.employeeId ?? '',
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
    required int index,
    bool isHeader = false,
    required String title0,
    required String title1,
    required String title2,
    required String title3,
    required String title4,
  }) {
    return Padding(
      padding: isHeader
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 80.0,
            child: TextFontStyle(
              isHeader ? title0 : '$title0.',
              size: isHeader ? fontSizeL : fontSizeM,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 20.0),
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
                            ClipboardData(
                                text: '$title2 $title3 รหัส: $title4'),
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
          isHeader
              ? const Icon(
            Icons.more_vert_rounded,
            size: fontSizeL,
            color: Colors.white,
          )
              : EditDeletePopup(
            selectedItem: selectedItem,
            onEdit: () async {
              _employeeController.selectedEmployeeId = index;

              bool? result =
              await Get.to(() => const AddEmployeePage(isEdit: true));

              if (result != null) {
                await _employeeController.getEmployee();

                setState(() {});
              }
            },
            onDelete: () async {
              _employeeController.selectedEmployeeId = index;
              await _employeeController
                  .deleteEmployee(_employeeController.selectedEmployeeId ?? 0);
              Get.back();

              await _employeeController.getEmployee();
              Get.back();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _employeeController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
