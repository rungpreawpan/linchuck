import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/dashboard/controller/dashboard_controller.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final DashboardController _dashboardController = Get.find();

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
    await _dashboardController.getFinance();

    if (_dashboardController.janData?.profit != null &&
        _dashboardController.febData?.profit != null &&
        _dashboardController.marData?.profit != null &&
        _dashboardController.aprData?.profit != null &&
        _dashboardController.mayData?.profit != null &&
        _dashboardController.junData?.profit != null &&
        _dashboardController.julData?.profit != null &&
        _dashboardController.augData?.profit != null &&
        _dashboardController.sepData?.profit != null &&
        _dashboardController.octData?.profit != null &&
        _dashboardController.novData?.profit != null &&
        _dashboardController.decData?.profit != null) {
      jan = (_dashboardController.janData!.profit! / 3000);
      feb = _dashboardController.febData!.profit! / 3000;
      mar = _dashboardController.marData!.profit! / 3000;
      apr = _dashboardController.aprData!.profit! / 3000;
      may = _dashboardController.mayData!.profit! / 3000;
      jun = _dashboardController.junData!.profit! / 3000;
      jul = _dashboardController.julData!.profit! / 3000;
      aug = _dashboardController.augData!.profit! / 3000;
      sep = _dashboardController.sepData!.profit! / 3000;
      oct = _dashboardController.octData!.profit! / 3000;
      nov = _dashboardController.novData!.profit! / 3000;
      dec = _dashboardController.decData!.profit! / 3000;
    }

    setState(() {});
  }

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFontStyle(
            'รายงานการเงิน',
            size: fontSizeL,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: marginX2),
          _areaCharts(),
        ],
      ),
    );
  }

  _areaCharts() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: marginX2,
        ),
        child: LineChart(mainData()),
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
}
