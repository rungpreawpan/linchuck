import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class AddEmployeePage extends StatefulWidget {
  final bool isEdit;

  const AddEmployeePage({
    super.key,
    this.isEdit = false,
  });

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final EmployeeController _employeeController = Get.find();
  final TextEditingController _firstnameController1 = TextEditingController();
  final TextEditingController _lastnameController1 = TextEditingController();
  final TextEditingController _firstnameController2 = TextEditingController();
  final TextEditingController _lastnameController2 = TextEditingController();
  final TextEditingController _firstnameController3 = TextEditingController();
  final TextEditingController _lastnameController3 = TextEditingController();
  final TextEditingController _firstnameController4 = TextEditingController();
  final TextEditingController _lastnameController4 = TextEditingController();
  final TextEditingController _firstnameController5 = TextEditingController();
  final TextEditingController _lastnameController5 = TextEditingController();

  int employeeNo = 1;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    if (widget.isEdit && _employeeController.selectedEmployeeId != null) {
      await _employeeController
          .getOneEmployee(_employeeController.selectedEmployeeId!);

      if (_employeeController.selectedEmployee != null) {
        UserModel? item = _employeeController.selectedEmployee;

        _firstnameController1.text = item?.firstname ?? '';
        _lastnameController1.text = item?.lastname ?? '';
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle:
          widget.isEdit ? 'แก้ไขรายชื่อพนักงาน' : 'เพิ่มรายชื่อพนักงาน',
      contentWidget: [
        Expanded(
          child: Column(
            children: [
              _employeeList(),
              const SizedBox(height: 20.0),
              _confirmAndCancelButton(),
            ],
          ),
        ),
        const SizedBox(width: 30.0),
      ],
      showActionButton: widget.isEdit ? false : true,
      actionButton: _addEmployeeButton(),
    );
  }

  _employeeList() {
    return Expanded(
      child: ListView.separated(
        itemCount: employeeNo,
        itemBuilder: !widget.isEdit
            ? (context, index) {
                if (index == 0) {
                  return _employeeData(
                    index: int.parse((index + 1).toString()),
                    firstnameController: _firstnameController1,
                    lastnameController: _lastnameController1,
                    deleteEmployee: () {
                      if (employeeNo != 1) {
                        employeeNo -= 1;
                      }

                      setState(() {});
                    },
                  );
                } else if (index == 1) {
                  return _employeeData(
                    index: int.parse((index + 1).toString()),
                    firstnameController: _firstnameController2,
                    lastnameController: _lastnameController2,
                    deleteEmployee: () {
                      if (employeeNo != 1) {
                        employeeNo -= 1;
                      }

                      setState(() {});
                    },
                  );
                } else if (index == 2) {
                  return _employeeData(
                    index: int.parse((index + 1).toString()),
                    firstnameController: _firstnameController3,
                    lastnameController: _lastnameController3,
                    deleteEmployee: () {
                      if (employeeNo != 1) {
                        employeeNo -= 1;
                      }

                      setState(() {});
                    },
                  );
                } else if (index == 3) {
                  return _employeeData(
                    index: int.parse((index + 1).toString()),
                    firstnameController: _firstnameController4,
                    lastnameController: _lastnameController4,
                    deleteEmployee: () {
                      if (employeeNo != 1) {
                        employeeNo -= 1;
                      }

                      setState(() {});
                    },
                  );
                } else if (index == 4) {
                  return _employeeData(
                    index: int.parse((index + 1).toString()),
                    firstnameController: _firstnameController5,
                    lastnameController: _lastnameController5,
                    deleteEmployee: () {
                      if (employeeNo != 1) {
                        employeeNo -= 1;
                      }

                      setState(() {});
                    },
                  );
                } else {
                  return const SizedBox();
                }
              }
            : (context, index) {
                return _employeeData(
                  index: 1,
                  firstnameController: _firstnameController1,
                  lastnameController: _lastnameController1,
                  deleteEmployee: () {},
                );
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
        SizedBox(width: widget.isEdit ? 0 : marginX2),
        widget.isEdit
            ? const SizedBox()
            : InkWell(
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
    return InkWell(
      onTap: () {
        if (employeeNo != 5) {
          employeeNo += 1;

          setState(() {});
        } else {
          Get.dialog(
            const CustomAlertDialog(title: 'เพิ่มพนักงานได้ไม่เกิน 5 คน'),
          );
        }
      },
      child: const Icon(
        Icons.add,
        color: primaryColor,
        size: fontSizeXL,
      ),
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
            onTap: widget.isEdit
                ? () async {
                    await _employeeController.editEmployee(
                      _employeeController.selectedEmployeeId ?? 0,
                      _firstnameController1.text,
                      _lastnameController1.text,
                    );
                  }
                : () async {
                    if (employeeNo == 1 &&
                        _firstnameController1.text != '' &&
                        _lastnameController1.text != '') {
                      _employeeController.addEmployee(
                        _firstnameController1.text,
                        _lastnameController1.text,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                      );
                    } else if (employeeNo == 2 &&
                        _firstnameController1.text != '' &&
                        _lastnameController1.text != '' &&
                        _firstnameController2.text != '' &&
                        _lastnameController2.text != '') {
                      _employeeController.addEmployee(
                        _firstnameController1.text,
                        _lastnameController1.text,
                        _firstnameController2.text,
                        _lastnameController2.text,
                        null,
                        null,
                        null,
                        null,
                        null,
                        null,
                      );
                    } else if (employeeNo == 3 &&
                        _firstnameController1.text != '' &&
                        _lastnameController1.text != '' &&
                        _firstnameController2.text != '' &&
                        _lastnameController2.text != '' &&
                        _firstnameController3.text != '' &&
                        _lastnameController3.text != '') {
                      _employeeController.addEmployee(
                        _firstnameController1.text,
                        _lastnameController1.text,
                        _firstnameController2.text,
                        _lastnameController2.text,
                        _firstnameController3.text,
                        _lastnameController3.text,
                        null,
                        null,
                        null,
                        null,
                      );
                    } else if (employeeNo == 4 &&
                        _firstnameController1.text != '' &&
                        _lastnameController1.text != '' &&
                        _firstnameController2.text != '' &&
                        _lastnameController2.text != '' &&
                        _firstnameController3.text != '' &&
                        _lastnameController3.text != '' &&
                        _firstnameController4.text != '' &&
                        _lastnameController4.text != '') {
                      _employeeController.addEmployee(
                        _firstnameController1.text,
                        _lastnameController1.text,
                        _firstnameController2.text,
                        _lastnameController2.text,
                        _firstnameController3.text,
                        _lastnameController3.text,
                        _firstnameController4.text,
                        _lastnameController4.text,
                        null,
                        null,
                      );
                    } else if (employeeNo == 5 &&
                        _firstnameController1.text != '' &&
                        _lastnameController1.text != '' &&
                        _firstnameController2.text != '' &&
                        _lastnameController2.text != '' &&
                        _firstnameController3.text != '' &&
                        _lastnameController3.text != '' &&
                        _firstnameController4.text != '' &&
                        _lastnameController4.text != '' &&
                        _firstnameController5.text != '' &&
                        _lastnameController5.text != '') {
                      _employeeController.addEmployee(
                        _firstnameController1.text,
                        _lastnameController1.text,
                        _firstnameController2.text,
                        _lastnameController2.text,
                        _firstnameController3.text,
                        _lastnameController3.text,
                        _firstnameController4.text,
                        _lastnameController4.text,
                        _firstnameController5.text,
                        _lastnameController5.text,
                      );
                    } else {
                      Get.dialog(
                          const CustomAlertDialog(title: 'กรุณากรอกข้อมูล'));
                    }
                  },
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }
}
