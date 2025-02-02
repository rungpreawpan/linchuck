import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/main_template.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return  MainTemplate(
      appBarTitle: 'คลังทั้งหมด',
      contentWidget: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // _addStockButton(), //TODO
                ],
              ),
              const SizedBox(height: marginX2),
              // _stockList(),
            ],
          ),
        ),
        const SizedBox(width: 30.0),
      ],
      showActionButton: true,
      actionButton: InkWell(
        onTap: () async {
          // await _prepareData();
        },
        child: const Icon(
          Icons.refresh_rounded,
          color: primaryColor,
        ),
      ),
    );
  }
}
