import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_select_date.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:flutter/services.dart';
import 'package:lin_chuck/widget/text_font_style.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class RequestPdfDialog extends StatefulWidget {
  const RequestPdfDialog({super.key});

  @override
  State<RequestPdfDialog> createState() => _RequestPdfDialogState();
}

class _RequestPdfDialogState extends State<RequestPdfDialog> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      contentPadding: const EdgeInsets.all(20.0),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 80.0,
          minWidth: 500.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TextFontStyle(
                'ออกรายงานยอดขาย',
                size: fontSizeXL,
                weight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            TextFontStyle(
              'เลือกวันที่สำหรับออกรายงาน',
              size: fontSizeM,
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                _selectedStartDate(),
                const SizedBox(width: margin),
                _selectedEndDate(),
              ],
            ),
            const SizedBox(height: 30.0),
            _genPDF(),
          ],
        ),
      ),
    );
  }

  _selectedStartDate() {
    return Expanded(
      child: InkWell(
        onTap: () async {
          _startDate = await datePicker(context);

          if (_startDate != null) {
            _startDateController.text =
                DateFormat('dd/MM/yyyy').format(_startDate!);

            setState(() {});
          }
        },
        child: CustomTextField(
          isEnabled: false,
          textEditingController: _startDateController,
          labelText: 'วันที่เริ่ม',
          suffix: const Icon(Icons.calendar_month_rounded),
        ),
      ),
    );
  }

  _selectedEndDate() {
    return Expanded(
      child: InkWell(
        onTap: () async {
          _endDate = await datePicker(context);

          if (_endDate != null) {
            _endDateController.text =
                DateFormat('dd/MM/yyyy').format(_endDate!);

            setState(() {});
          }
        },
        child: CustomTextField(
          isEnabled: false,
          textEditingController: _endDateController,
          labelText: 'วันที่สิ้นสุด',
          suffix: const Icon(Icons.calendar_month_rounded),
        ),
      ),
    );
  }

  Future<void> generateAndSavePDF(BuildContext context) async {
    final pdf = pw.Document();

    final ByteData bytes = await rootBundle.load('assets/icons/logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final pw.MemoryImage logo = pw.MemoryImage(byteList);
    final fontRegular = pw.Font.ttf(
        await rootBundle.load('assets/font/Sarabun/Sarabun-Regular.ttf'));
    final fontBold = pw.Font.ttf(
        await rootBundle.load('assets/font/Sarabun/Sarabun-Bold.ttf'));

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'รายงานยอดขาย',
                  style: pw.TextStyle(
                    font: fontBold,
                    fontSize: 16.0,
                  ),
                ),
                pw.Image(
                  logo,
                  width: 35.0,
                  height: 35.0,
                ),
              ],
            ),
            pw.Text(
              '5 กันยายน 2025',
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 16.0,
              ),
            ),
            pw.SizedBox(height: 30.0),
            pw.Text(
              'CODE&KAFF - พัฒนาการ',
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 16.0,
              ),
            ),
            pw.SizedBox(height: 30.0),
            pw.Text(
              'สรุปข้อมูล',
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 14.0,
              ),
            ),
            pw.Table.fromTextArray(
              data: [
                ['รายรับทั้งหมด', 'คำสั่งซื้อ'],
                ['5000บาท', '25 รายการ'],
              ],
              headerStyle: pw.TextStyle(
                font: fontBold,
                fontSize: 14.0,
              ),
              cellStyle: pw.TextStyle(
                font: fontRegular,
                fontSize: 14.0,
              ),
            ),
            pw.SizedBox(height: 30.0),
            pw.Text(
              'ข้อมูลคำสั่งซื้อ',
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 14.0,
              ),
            ),
            pw.Table.fromTextArray(
              data: [
                [
                  'ลำดับ',
                  'วันที่สั่งซื้อ',
                  'รหัสใบเสร็จ',
                  'วิธีชำระเงิน',
                  'พนักงานขาย',
                  'ยอดขาย (บาท)'
                ],
                ['1', '1/1/2025', '123456', 'Promptpay', 'A', '100'],
              ],
              headerStyle: pw.TextStyle(
                font: fontBold,
                fontSize: 14.0,
                fontWeight: pw.FontWeight.bold,
              ),
              cellStyle: pw.TextStyle(
                font: fontRegular,
                fontSize: 14.0,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    // Get the directory for saving the file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/รายงานยอดขาย.pdf";
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());

    OpenFile.open(filePath);
  }

  _genPDF() {
    return CustomSubmitButton(
      onTap: () {
        generateAndSavePDF(context);
      },
      title: 'ออกรายงาน',
      backgroundColor: primaryColor,
      borderRadius: 10.0,
    );
  }
}
