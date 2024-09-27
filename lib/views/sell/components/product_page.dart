import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/sell/components/chart_indicator.dart';
import 'package:lin_chuck/views/sell/controller/sell_controller.dart';
import 'package:lin_chuck/views/sell/model/sell_model.dart';

class ProductPage extends StatefulWidget {
  final SellModel sellData;

  const ProductPage({
    super.key,
    required this.sellData,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final SellController _sellController = Get.find();

  int touchedIndex = -1;

  List<Color> colorList = [
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
    Colors.primaries[Random().nextInt(Colors.primaries.length)],
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _productCharts(),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _sellController.sellData!.sellProduct!.map(
              (e) {
                int index = _sellController.sellData!.sellProduct!.indexOf(e);

                return Padding(
                  padding: const EdgeInsets.only(bottom: marginX2),
                  child: Indicator(
                    color: colorList[index],
                    text: e.name ?? '',
                    isSquare: true,
                    size: 30.0,
                    fontSize: 20.0,
                    padding: marginX2,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  _productCharts() {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            if (!event.isInterestedForInteractions ||
                pieTouchResponse == null ||
                pieTouchResponse.touchedSection == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;

            setState(() {});
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 180,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    double total = 0;

    for (SellProductModel product in _sellController.sellData!.sellProduct!) {
      total += product.count!;
    }

    return List.generate(_sellController.sellData!.sellProduct!.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: colorList[i],
        value: _sellController.sellData!.sellProduct![i].count!.toDouble(),
        title:
            '${(_sellController.sellData!.sellProduct![i].count!.toDouble() / total * 100).toStringAsFixed(2)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: shadows,
          fontFamily: GoogleFonts.kanit().fontFamily,
        ),
      );
    });
  }
}
