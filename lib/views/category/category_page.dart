import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/views/category/add_category_page.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/views/home/model/product_type_model.dart';
import 'package:lin_chuck/widget/custom_loading.dart';
import 'package:lin_chuck/widget/edit_delete_popup.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final HomeController _homeController = Get.find();

  String selectedItem = '';

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    _homeController.getProductType();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainTemplate(
          appBarTitle: 'หมวดหมู่สินค้า',
          contentWidget: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _addCategoryButton(),
                    ],
                  ),
                  const SizedBox(height: marginX2),
                  _categoryList(),
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

  _addCategoryButton() {
    return InkWell(
      onTap: () async {
        bool? result = await Get.to(() => const AddCategoryPage());

        if (result != null) {
          //TODO:
          // await _homeController.getProduct();

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
            'เพิ่มหมวดหมู่สินค้า',
            color: Colors.white,
            size: fontSizeM,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _categoryList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _categoryRow(
            index: 0,
            isHeader: true,
            title1: 'ลำดับที่',
            title2: 'ชื่อหมวดหมู่',
            title3: 'จำนวน',
          ),
          const Divider(color: Colors.black),
          Expanded(
            child: ListView.separated(
              itemCount: _homeController.productTypeList.length,
              itemBuilder: (context, index) {
                ProductTypeModel item = _homeController.productTypeList[index];

                return _categoryRow(
                  index: item.id ?? 0,
                  title1: (index + 1).toString(),
                  title2: item.name ?? '',
                  title3: item.quantity.toString(),
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

  _categoryRow({
    required int index,
    bool isHeader = false,
    required String title1,
    required String title2,
    required String title3,
  }) {
    return Padding(
      padding: isHeader
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(vertical: margin),
      child: Row(
        children: [
          Expanded(
            child: TextFontStyle(
              title1,
              size: fontSizeL,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          // const SizedBox(width: 20.0),
          Expanded(
            flex: 3,
            child: TextFontStyle(
              title2,
              size: fontSizeL,
              weight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFontStyle(
              title3,
              size: fontSizeL,
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
                  onEdit: () async {
                    _homeController.selectedProductTypeId = index;

                    bool? result =
                        await Get.to(() => const AddCategoryPage(isEdit: true));

                    if (result != null) {
                      await _homeController.getProductType();

                      setState(() {});
                    }
                  },
                  onDelete: () async {
                    _homeController.selectedProductTypeId = index;
                    await _homeController
                        .deleteProductType(_homeController.selectedProductTypeId ?? 0);
                    Get.back();

                    await _homeController.getProductType();
                    setState(() {});
                  },
                ),
        ],
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
