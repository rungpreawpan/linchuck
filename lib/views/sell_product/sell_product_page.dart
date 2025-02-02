import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_model.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/views/promotion/controller/promotion_controller.dart';
import 'package:lin_chuck/views/promotion/model/promotion_model.dart';
import 'package:lin_chuck/views/sell_product/add_sell_product_page.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/edit_delete_popup.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class SellProductPage extends StatefulWidget {
  const SellProductPage({super.key});

  @override
  State<SellProductPage> createState() => _SellProductPageState();
}

class _SellProductPageState extends State<SellProductPage> {
  final HomeController _homeController = Get.find();
  final PromotionController _promotionController = Get.find();

  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _homeController.getProduct();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'สินค้าทั้งหมด',
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
            child: const Icon(
              Icons.refresh_rounded,
              color: primaryColor,
            ),
          ),
        ),
        _loading(),
      ],
    );
  }

  _addStockButton() {
    return InkWell(
      onTap: () async {
        bool? result = await Get.to(() => const AddSellProductPage());

        if (result != null) {
          await _homeController.getProduct();

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
            'เพิ่มสินค้า',
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
            title1: 'สินค้า',
            title2: 'หมวดหมู่',
            title3: 'ราคา',
            title4: 'โปรโมชั่น',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: _homeController.productList.length,
              itemBuilder: (context, index) {
                ProductModel item = _homeController.productList[index];
                String productType = '-';
                String promotionName = '-';

                for (PromotionModel promotion
                    in _promotionController.promotionList) {
                  if (item.promotionId == promotion.promotionId) {
                    promotionName = promotion.promotionName ?? '-';
                  }
                }

                for (ProductTypeModel type in _homeController.productTypeList) {
                  if (type.id == item.productTypeId) {
                    productType = type.name ?? '';
                  }
                }

                return _stockRow(
                  index: item.id ?? 0,
                  title1: item.name ?? '',
                  title2: productType,
                  title3: item.productPrice.toString(),
                  title4: promotionName,
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
    required String title1,
    required String title2,
    required String title3,
    required String title4,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: !isHeader
              ? Container(
                  height: 80.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              : null,
        ),
        const SizedBox(width: 30.0),
        Expanded(
          child: TextFontStyle(
            title1,
            size: isHeader ? fontSizeL : fontSizeM,
            weight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFontStyle(
                title4,
                size: isHeader ? fontSizeL : fontSizeM,
                weight: isHeader ? FontWeight.bold : FontWeight.normal,
              ),
            ],
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
                onEdit: () async {
                  _homeController.selectedProductId = index;

                  bool? result = await Get.to(
                    () => const AddSellProductPage(isEdit: true),
                  );

                  if (result != null) {
                    await _homeController.getProduct();

                    setState(() {});
                  }
                },
                onDelete: () async {
                  _homeController.selectedProductId = index;
                  await _homeController
                      .deleteProduct(_homeController.selectedProductId ?? 0);
                  Get.back();

                  await _homeController.getProduct();
                  setState(() {});
                },
              ),
      ],
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
