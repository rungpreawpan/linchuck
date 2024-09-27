import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/category/category_page.dart';
import 'package:lin_chuck/views/home/components/menu_card.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/stock/stock_page.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/views/home/components/order_list_card.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  int currentIndex = 0;
  List<ProductTypeModel> productTypeList = [];

  List<ProductModel> _filterProductList = [];

  List<String> popupItems = ['หมวดหมู่สินค้า', 'สินค้า'];

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _homeController.getSweet();
    await _homeController.getProductType();
    await _getProductType();
    await _homeController.getProduct();
    await _getFilterProduct();

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

  _getFilterProduct() {
    if (currentIndex == 0) {
      _filterProductList = _homeController.productList;
    } else {
      _filterProductList = _homeController.productList
          .where((product) =>
              product.productTypeId == _homeController.selectedProductTypeId)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'รายการสินค้า',
          showActionButton: true,
          actionButton: _popUp(),
          contentWidget: [
            _menu(),
            const SizedBox(width: 20.0),
            const OrderListCard(),
          ],
        ),
        _loading(),
      ],
    );
  }

  _menu() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productType(),
          const SizedBox(height: 20.0),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: marginX2,
                crossAxisSpacing: marginX2,
                childAspectRatio: 1.0,
              ),
              itemCount: _filterProductList.length,
              itemBuilder: (context, index) {
                ProductModel item = _filterProductList[index];

                return MenuCard(product: item);
              },
            ),
          ),
        ],
      ),
    );
  }

  _productType() {
    return SizedBox(
      height: 50.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: productTypeList.length,
        itemBuilder: (context, index) {
          ProductTypeModel item = productTypeList[index];

          return CustomButton(
            onTap: () {
              currentIndex = index;
              _homeController.selectedProductTypeId = item.id;
              _getFilterProduct();

              setState(() {});
            },
            title: index != 0
                ? '${item.name} (${item.quantity})'
                : '${item.name} (${_homeController.productList.length})',
            isSelected: currentIndex == index,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginX2);
        },
      ),
    );
  }

  _popUp() {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return popupItems.map((data) {
          return PopupMenuItem<String>(
            value: data,
            child: InkWell(
              onTap: data == 'สินค้า'
                  ? () {
                      Get.back();
                      Get.to(() => const StockPage());
                    }
                  : () {
                      Get.back();
                      Get.to(() => const CategoryPage());
                    },
              child: TextFontStyle(
                data,
                size: fontSizeM,
              ),
            ),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      offset: const Offset(0, 30),
      child: const Icon(Icons.tune_rounded),
    );
  }

  _loading() {
    return Obx(() {
      return Visibility(
        visible: _homeController.isLoading.value,
        child: const CustomLoading(),
      );
    });
  }
}
