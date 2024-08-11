import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/model/data_model.dart';
import 'package:lin_chuck/views/home/components/add_category_dialog.dart';
import 'package:lin_chuck/views/home/components/menu_card.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/widget/custom_app_bar.dart';
import 'package:lin_chuck/widget/custom_button.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/views/home/components/receipt.dart';
import 'package:lin_chuck/widget/custom_side_bar.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
    return Scaffold(
      key: _drawerKey,
      drawer: const CustomDrawer(),
      body: _content(),
    );
  }

  _content() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 20.0,
          top: 20.0,
          bottom: 20.0,
        ),
        child: Row(
          children: [
            CustomSideBar(
              onTap: () {
                _drawerKey.currentState!.openDrawer();
              },
            ),
            _mainContent(),
          ],
        ),
      ),
    );
  }

  _mainContent() {
    return Expanded(
      child: Column(
        children: [
          const CustomAppBar(title: 'รายการสินค้า'),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _menu(),
                const SizedBox(width: 20.0),
                const Receipt(),
              ],
            ),
          ),
        ],
      ),
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
