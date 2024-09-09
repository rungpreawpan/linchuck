import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/model/data_model.dart';
import 'package:lin_chuck/views/home/components/add_category_dialog.dart';
import 'package:lin_chuck/views/home/components/menu_card.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/views/home/components/order_list_card.dart';
import 'package:lin_chuck/widget/main_template.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();

    _prepareData();
  }

  _prepareData() async {
    await _homeController.getCategories();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainTemplate(
      appBarTitle: 'รายการสินค้า',
      contentWidget: [
        _menu(),
        const SizedBox(width: 20.0),
        const OrderListCard(),
      ],
    );
  }

  _menu() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _categories(),
          const SizedBox(height: 20.0),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: marginX2,
                crossAxisSpacing: marginX2,
                childAspectRatio: 1.0,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return const MenuCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  _categories() {
    return SizedBox(
      height: 50.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _homeController.categoryList.length,
        itemBuilder: (context, index) {
          DataModel item = _homeController.categoryList[index];

          if (index == _homeController.categoryList.length - 1) {
            return Row(
              children: [
                CustomButton(
                  onTap: () {},
                  title: '${item.name} (3)',
                ),
                const SizedBox(width: marginX2),
                InkWell(
                  onTap: () {
                    Get.dialog(const AddCategoryDialog());
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
              onTap: () {},
              title: '${item.name} (3)',
              //TODO: edit json
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginX2);
        },
      ),
    );
  }
}
