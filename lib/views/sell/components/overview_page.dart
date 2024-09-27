import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/sell/components/chart_indicator.dart';
import 'package:lin_chuck/views/sell/controller/sell_controller.dart';
import 'package:lin_chuck/views/sell/model/sell_model.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class OverviewPage extends StatefulWidget {
  final SellModel sellData;

  const OverviewPage({
    super.key,
    required this.sellData,
  });

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final SellController _sellController = Get.find();

  double? jan;
  double? feb;
  double? mar;
  double? apr;
  double? may;
  double? jun;
  double? jul;
  double? aug;
  double? sep;
  double? oct;
  double? nov;
  double? dec;

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _sellController.getFinance();

    if (_sellController.janData?.sales != null &&
        _sellController.febData?.sales != null &&
        _sellController.marData?.sales != null &&
        _sellController.aprData?.sales != null &&
        _sellController.mayData?.sales != null &&
        _sellController.junData?.sales != null &&
        _sellController.julData?.sales != null &&
        _sellController.augData?.sales != null &&
        _sellController.sepData?.sales != null &&
        _sellController.octData?.sales != null &&
        _sellController.novData?.sales != null &&
        _sellController.decData?.sales != null) {
      jan = (_sellController.janData!.sales! / 3000);
      feb = _sellController.febData!.sales! / 3000;
      mar = _sellController.marData!.sales! / 3000;
      apr = _sellController.aprData!.sales! / 3000;
      may = _sellController.mayData!.sales! / 3000;
      jun = _sellController.junData!.sales! / 3000;
      jul = _sellController.julData!.sales! / 3000;
      aug = _sellController.augData!.sales! / 3000;
      sep = _sellController.sepData!.sales! / 3000;
      oct = _sellController.octData!.sales! / 3000;
      nov = _sellController.novData!.sales! / 3000;
      dec = _sellController.decData!.sales! / 3000;
    }

    setState(() {});
  }

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

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
    return Column(
      children: [
        _summaryData(),
        const SizedBox(height: 20.0),
        Expanded(
          child: Row(
            children: [
              _sellChart(),
              const SizedBox(width: marginX2),
              _bestSellingProductsChart(),
            ],
          ),
        ),
      ],
    );
  }

  _summaryData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _dataBox(
          title: 'รายการขาย',
          value: widget.sellData.allOrder.toString(),
          unit: 'รายการ',
        ),
        const SizedBox(width: marginX2),
        _dataBox(
          title: 'ยอดขาย',
          value: widget.sellData.sales.toString(),
          unit: 'บาท',
        ),
        const SizedBox(width: marginX2),
        _dataBox(
          title: 'ต้นทุน',
          value: widget.sellData.allCosts.toString(),
          unit: 'บาท',
        ),
        const SizedBox(width: marginX2),
        _dataBox(
          title: 'กำไร',
          value: widget.sellData.profit.toString(),
          unit: 'บาท',
        ),
      ],
    );
  }

  _dataBox({
    required String title,
    required String value,
    required String unit,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            TextFontStyle(
              title,
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFontStyle(
                  value.toString(),
                  color: title == 'กำไร'
                      ? double.parse(value) > 0
                          ? Colors.green
                          : Colors.red
                      : Colors.black,
                  size: fontSizeL,
                  weight: FontWeight.bold,
                ),
                const SizedBox(width: margin),
                TextFontStyle(
                  unit,
                  size: fontSizeM,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _sellChart() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFontStyle(
              'เปรียบเทียบยอดขาย',
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: marginX2),
            Expanded(
              child: LineChart(mainData()),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
      case 1:
        text = const Text('FEB', style: style);
        break;
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 3:
        text = const Text('APR', style: style);
        break;
      case 4:
        text = const Text('MAY', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 6:
        text = const Text('JUL', style: style);
        break;
      case 7:
        text = const Text('AUG', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 9:
        text = const Text('OCT', style: style);
        break;
      case 10:
        text = const Text('NOV', style: style);
        break;
      case 11:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '3K';
        break;
      case 2:
        text = '6k';
        break;
      case 3:
        text = '9k';
        break;
      case 4:
        text = '12k';
        break;
      case 5:
        text = '15k';
        break;
      case 6:
        text = '18k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, jan ?? 0),
            FlSpot(1, feb ?? 0),
            FlSpot(2, mar ?? 0),
            FlSpot(3, apr ?? 0),
            FlSpot(4, may ?? 0),
            FlSpot(5, jun ?? 0),
            FlSpot(6, jul ?? 0),
            FlSpot(7, aug ?? 0),
            FlSpot(8, sep ?? 0),
            FlSpot(9, oct ?? 0),
            FlSpot(10, nov ?? 0),
            FlSpot(11, dec ?? 0),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  _bestSellingProductsChart() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFontStyle(
              'สินค้าขายดี',
              size: fontSizeM,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: margin),
            Expanded(
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;

                      setState(() {});
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
            const SizedBox(height: margin),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _sellController.sellData!.sellProduct!.map(
                (e) {
                  int index = _sellController.sellData!.sellProduct!.indexOf(e);

                  return Indicator(
                    color: colorList[index],
                    text: e.name ?? '',
                    isSquare: true,
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    double total = 0;

    for (SellProductModel product in _sellController.sellData!.sellProduct!) {
      total += product.count!;
    }

    return List.generate(
      _sellController.sellData!.sellProduct!.length,
      (i) {
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
      },
    );
  }
}
