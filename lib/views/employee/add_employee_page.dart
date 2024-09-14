import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/employee/controller/employee_controller.dart';
import 'package:lin_chuck/views/login/model/user_model.dart';
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
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

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
                TextEditingController firstnameController$index =
                    TextEditingController();
                TextEditingController lastnameController$index =
                    TextEditingController();

                return _employeeData(
                  index: int.parse((index + 1).toString()),
                  firstnameController: firstnameController$index,
                  lastnameController: lastnameController$index,
                  deleteEmployee: () {
                    if (employeeNo != 1) {
                      employeeNo -= 1;
                    }

                    setState(() {});
                  },
                );
              }
            : (context, index) {
                _firstnameController.text =
                    _employeeController.selectedEmployee?.firstname ?? '';
                _lastnameController.text =
                    _employeeController.selectedEmployee?.lastname ?? '';

                return _employeeData(
                  index: 1,
                  firstnameController: _firstnameController,
                  lastnameController: _lastnameController,
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
        employeeNo += 1;

        setState(() {});
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
                      _firstnameController.text,
                      _lastnameController.text,
                    );
                  }
                : () async {},
            title: 'ยืนยัน',
            backgroundColor: primaryColor,
          ),
        ),
      ],
    );
  }
}
