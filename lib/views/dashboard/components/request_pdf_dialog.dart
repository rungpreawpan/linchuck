import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/dashboard/controller/dashboard_controller.dart';
import 'package:lin_chuck/views/dashboard/model/dashboard_model.dart';
import 'package:lin_chuck/widget/custom_alert_dialog.dart';
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
  final DashboardController _dashboardController = Get.find();

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  bool loadingComplete = false;

  List<SummaryOrderModel> order = [];

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
          labelText: 'วันที่เริ่มต้น',
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
                  'รายงานยอดขายประจำวันที่',
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
              _startDate != null && _endDate != null
                  ? '${DateFormat('dd/MM/yyyy').format(_startDate!)} - ${DateFormat('dd/MM/yyyy').format(_endDate!)}'
                  : '',
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
            pw.SizedBox(height: 5.0),
            pw.Table.fromTextArray(
              headers: ['รายรับทั้งหมด', 'คำสั่งซื้อ'],
              data: [
                [
                  '${_dashboardController.reportData?.sales?.toStringAsFixed(2)} บาท',
                  '${_dashboardController.reportData?.allOrder ?? 0} รายการ'
                ],
              ],
              headerStyle: pw.TextStyle(
                font: fontBold,
                fontSize: 14.0,
              ),
              cellStyle: pw.TextStyle(
                font: fontRegular,
                fontSize: 14.0,
              ),
              cellAlignment: pw.Alignment.center,
            ),
            pw.SizedBox(height: 30.0),
            pw.Text(
              'ข้อมูลคำสั่งซื้อ',
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 14.0,
              ),
            ),
            pw.SizedBox(height: 5.0),
            pw.Table.fromTextArray(
              headers: [
                'ลำดับ',
                'วันที่สั่งซื้อ',
                'รหัสใบเสร็จ',
                'วิธีชำระเงิน',
                'พนักงานขาย',
                'ยอดขาย (บาท)'
              ],
              data: order.asMap().entries
                  .map((e) => [
                        e.key + 1,
                        DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(e.value.orderDate!)),
                        e.value.receiptNo,
                        e.value.paymentType,
                        e.value.username,
                        e.value.total.toString(),
                      ])
                  .toList(),
              headerStyle: pw.TextStyle(
                font: fontBold,
                fontSize: 14.0,
                fontWeight: pw.FontWeight.bold,
              ),
              cellStyle: pw.TextStyle(
                font: fontRegular,
                fontSize: 12.0,
                fontWeight: pw.FontWeight.bold,
              ),
              cellAlignment: pw.Alignment.center,
            ),
          ],
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/รายงานยอดขาย.pdf";
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());

    OpenFile.open(filePath);
  }

  _genPDF() {
    return CustomSubmitButton(
      onTap: () async {
        if (_startDate == null) {
          Get.dialog(CustomAlertDialog(title: 'กรุณาเลือกวันที่เริ่มต้น'));
        } else if (_endDate == null) {
          Get.dialog(CustomAlertDialog(title: 'กรุณาเลือกวันที่สิ้นสุด'));
        } else {
          loadingComplete = true;
          order.clear();

          await _dashboardController.getReportData(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(_startDate!),
              DateFormat('yyyy-MM-dd 23:59:59').format(_endDate!));

          if (_dashboardController.reportData?.order != null &&
              _dashboardController.reportData!.order!.isNotEmpty) {
            for (SummaryOrderModel data
                in _dashboardController.reportData!.order!) {
              order.add(data);
            }
          }

          loadingComplete = false;

          if (!loadingComplete) {
            generateAndSavePDF(context);
          }
        }
      },
      title: 'ออกรายงาน',
      backgroundColor: primaryColor,
      borderRadius: 10.0,
    );
  }
}
