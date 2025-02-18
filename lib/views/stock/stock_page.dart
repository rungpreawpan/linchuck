import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/delete_dialog.dart';
import 'package:lin_chuck/views/stock/add_stock_page.dart';
import 'package:lin_chuck/views/stock/controller/stock_controller.dart';
import 'package:lin_chuck/views/stock/model/stock_model.dart';
import 'package:lin_chuck/widget/edit_delete_popup.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final StockController _stockController = Get.find();

  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _stockController.getIngredient();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'วัตถุดิบทั้งหมด',
      contentWidget: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _addStockButton(),
                ],
              ),
              const SizedBox(height: marginX2),
              _stockList(),
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
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }

  _addStockButton() {
    return InkWell(
      onTap: () async {
        bool? result = await Get.to(() => const AddStockPage());

        if (result != null) {
          await _stockController.getIngredient();

          setState(() {});
        }
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
            'เพิ่มวัตถุดิบ',
            color: Colors.white,
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _stockList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stockRow(
            isHeader: true,
            index: 0,
            title0: 'ชื่อวัตถุดิบ',
            title1: 'Lot No.',
            title2: 'จำนวน',
            title3: 'วันที่สั่งซื้อ',
            title4: 'วันที่หมดอายุ',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: _stockController.stockList.length,
              itemBuilder: (context, index) {
                StockModel item = _stockController.stockList[index];
                String orderDate = DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(item.orderDate!));
                String expireDate = DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(item.expireDate!));

                return _stockRow(
                  index: item.ingredientsId ?? 0,
                  title0: item.ingredientName ?? '-',
                  title1: item.lotNumber ?? '-',
                  title2: item.orderAmount != null
                      ? '${item.orderAmount.toString()} ${item.unitName}'
                      : '0',
                  title3: orderDate,
                  title4: expireDate,
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

  _stockRow({
    bool isHeader = false,
    required int index,
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
          Expanded(
            child: TextFontStyle(
              title0,
              size: isHeader ? fontSizeL : fontSizeM,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Expanded(
            child: TextFontStyle(
              title1,
              size: isHeader ? fontSizeL : fontSizeM,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
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
            child: TextFontStyle(
              title4,
              size: isHeader ? fontSizeL : fontSizeM,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
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
                  showEdit: true,
                  onEdit: () async {
                    _stockController.selectedStockId = index;
                    bool? result =
                        await Get.to(() => const AddStockPage(isEdit: true));

                    if (result != null) {
                      Get.back();
                      await _stockController.getIngredient();

                      setState(() {});
                    }
                  },
                  onDelete: () async {
                    _stockController.selectedStockId = index;
                    bool? result = await Get.dialog(const DeleteDialog());

                    if (result != null) {
                      await _stockController.deleteIngredient(
                          _stockController.selectedStockId ?? 0);
                      Get.back();

                      await _stockController.getIngredient();
                      Get.back();
                      setState(() {});
                    }
                  },
                ),
        ],
      ),
    );
  }
}
