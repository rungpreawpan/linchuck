import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/components/add_category_dialog.dart';
import 'package:lin_chuck/views/home/components/menu_card.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/views/home/components/order_list_card.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/main_template.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  int currentIndex = 0;
  List<ProductTypeModel> productTypeList = [];

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'รายการสินค้า',
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
          //TODO: edit filter product type
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: marginX2,
                crossAxisSpacing: marginX2,
                childAspectRatio: 1.0,
              ),
              itemCount: _homeController.productList.length,
              itemBuilder: (context, index) {
                ProductModel item = _homeController.productList[index];

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

          if (index == productTypeList.length - 1) {
            return Row(
              children: [
                CustomButton(
                  onTap: () {
                    currentIndex = index;
                    setState(() {});
                  },
                  title: '${item.name} (${item.quantity})',
                  isSelected: currentIndex == index,
                ),
                const SizedBox(width: marginX2),
                InkWell(
                  onTap: () async {
                    bool? result = await Get.dialog(const AddCategoryDialog());

                    if (result != null) {
                      await _prepareData();
                      setState(() {});
                    }
                  },
                  child: const Icon(
                    Icons.add_circle_rounded,
                    color: Colors.green,
                    size: 30.0,
                  ),
                ),
              ],
            );
          } else {
            return CustomButton(
              onTap: () {
                currentIndex = index;
                setState(() {});
              },
              title: index != 0
                  ? '${item.name} (${item.quantity})'
                  : '${item.name} (${_homeController.productList.length})',
              isSelected: currentIndex == index,
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginX2);
        },
      ),
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
