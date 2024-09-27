import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/sell/controller/sell_controller.dart';
import 'package:lin_chuck/views/sell/model/sell_model.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class SellReportPage extends StatefulWidget {
  final SellModel sellData;

  const SellReportPage({
    super.key,
    required this.sellData,
  });

  @override
  State<SellReportPage> createState() => _SellReportPageState();
}

class _SellReportPageState extends State<SellReportPage> {
  final HomeController _homeController = Get.find();
  final SellController _sellController = Get.find();

  int currentIndex = 0;
  List<ProductTypeModel> productTypeList = [];

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
    await _homeController.getProductType();
    await _getProductType();
    await _getSellData();

    setState(() {});
  }

  _getProductType() {
    productTypeList.clear();

    ProductTypeModel data = ProductTypeModel(
      id: 0,
      name: 'ทั้งหมด',
      quantity: _homeController.productTypeList.length,
    );

    productTypeList.add(data);

    for (ProductTypeModel productType in _homeController.productTypeList) {
      productTypeList.add(productType);
    }
  }

  _getSellData() async {
    if (_sellController.janData?.allOrder != null &&
        _sellController.febData?.allOrder != null &&
        _sellController.marData?.allOrder != null &&
        _sellController.aprData?.allOrder != null &&
        _sellController.mayData?.allOrder != null &&
        _sellController.junData?.allOrder != null &&
        _sellController.julData?.allOrder != null &&
        _sellController.augData?.allOrder != null &&
        _sellController.sepData?.allOrder != null &&
        _sellController.octData?.allOrder != null &&
        _sellController.novData?.allOrder != null &&
        _sellController.decData?.allOrder != null) {
      if (currentIndex == 0) {
        jan = _sellController.janData!.allOrder!.toDouble() / 5;
        feb = _sellController.febData!.allOrder!.toDouble() / 5;
        mar = _sellController.marData!.allOrder!.toDouble() / 5;
        apr = _sellController.aprData!.allOrder!.toDouble() / 5;
        may = _sellController.mayData!.allOrder!.toDouble() / 5;
        jun = _sellController.junData!.allOrder!.toDouble() / 5;
        jul = _sellController.julData!.allOrder!.toDouble() / 5;
        aug = _sellController.augData!.allOrder!.toDouble() / 5;
        sep = _sellController.sepData!.allOrder!.toDouble() / 5;
        oct = _sellController.octData!.allOrder!.toDouble() / 5;
        nov = _sellController.novData!.allOrder!.toDouble() / 5;
        dec = _sellController.decData!.allOrder!.toDouble() / 5;
      } else {
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.janData!.sellTypes!) {
              if (sellType.id == type.id) {
                jan = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.febData!.sellTypes!) {
              if (sellType.id == type.id) {
                feb = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.marData!.sellTypes!) {
              if (sellType.id == type.id) {
                mar = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.aprData!.sellTypes!) {
              if (sellType.id == type.id) {
                apr = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.mayData!.sellTypes!) {
              if (sellType.id == type.id) {
                may = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.junData!.sellTypes!) {
              if (sellType.id == type.id) {
                jun = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.julData!.sellTypes!) {
              if (sellType.id == type.id) {
                jul = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.augData!.sellTypes!) {
              if (sellType.id == type.id) {
                aug = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.sepData!.sellTypes!) {
              if (sellType.id == type.id) {
                sep = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.octData!.sellTypes!) {
              if (sellType.id == type.id) {
                oct = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.novData!.sellTypes!) {
              if (sellType.id == type.id) {
                nov = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
        for (ProductTypeModel type in _homeController.productTypeList) {
          if (currentIndex == type.id) {
            for (SellTypesModel sellType
                in _sellController.decData!.sellTypes!) {
              if (sellType.id == type.id) {
                dec = sellType.count!.toDouble() / 5;
              }
            }
          }
        }
      }
    }
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
            'รายการขายแบ่งตามประเภทสินค้า',
            size: fontSizeL,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: marginX2),
          _productTypeList(),
          const SizedBox(height: 20.0),
          _areaCharts(),
        ],
      ),
    );
  }

  _productTypeList() {
    return SizedBox(
      height: 50.0,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: productTypeList.length,
        itemBuilder: (context, index) {
          ProductTypeModel item = productTypeList[index];

          return CustomButton(
            onTap: () {
              currentIndex = index;
              _homeController.selectedProductTypeId = item.id;
              _getSellData();

              setState(() {});
            },
            title: item.name ?? '',
            isSelected: currentIndex == index,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginX2);
        },
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
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '5';
        break;
      case 2:
        text = '10';
        break;
      case 3:
        text = '15';
        break;
      case 4:
        text = '20';
        break;
      case 5:
        text = '25';
        break;
      case 6:
        text = '30';
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
