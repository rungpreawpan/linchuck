import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';

datePicker(BuildContext context) {
  return showDatePicker(
    context: context,
    locale: const Locale('th', 'TH'),
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: primaryColor,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
    confirmText: 'ยืนยัน',
    cancelText: 'ยกเลิก',
  );
}