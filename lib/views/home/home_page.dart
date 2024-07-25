import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/model/data_model.dart';
import 'package:lin_chuck/views/home/controller/home_controller.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/widget/receipt.dart';
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
            _sideBar(),
            _mainContent(),
          ],
        ),
      ),
    );
  }

  _appBar() {
    return SizedBox(
      width: Get.width,
      child: const Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFontStyle(
              'รายการสินค้า',
              size: 40.0,
              weight: FontWeight.bold,
            ),
            Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }

  _sideBar() {
    return SizedBox(
      height: Get.height,
      width: 60.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            _drawerKey.currentState!.openDrawer();
          },
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _mainContent() {
    return Expanded(
      child: Column(
        children: [
          _appBar(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _menu(),
              Container(
                color: Colors.grey,
                height: 200,
              ),
              const SizedBox(width: 20.0),
              const Receipt(),
            ],
          ),
        ],
      ),
    );
  }

  _menu() {
    return Expanded(
      child: Column(
        children: [
          _categories(),
          const SizedBox(height: 20.0),
          Container(
            color: Colors.black,
            height: 100,
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
                _categoryButton(
                  onTap: () {},
                  title: item.name ?? '',
                ),
                const SizedBox(width: marginX2),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.add_circle_rounded,
                    color: Colors.green,
                    size: 30.0,
                  ),
                ),
              ],
            );
          } else {
            return _categoryButton(
              onTap: () {},
              title: item.name ?? '',
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: marginX2);
        },
      ),
    );
  }

  _categoryButton({
    required Function() onTap,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: TextFontStyle(
            title,
            size: fontSizeM,
          ),
        ),
      ),
    );
  }
}
