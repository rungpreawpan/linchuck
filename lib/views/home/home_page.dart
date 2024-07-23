import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const CustomDrawer(),
      body: _content(),
    );
  }

  _content() {
    return Row(
      children: [
        _sideBar(),
        _mainContent(),
      ],
    );
  }

  _sideBar() {
    return Container(
      height: Get.height,
      width: 80.0,
      padding: const EdgeInsets.only(top: 40.0),
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
      child: Container(
        color: Colors.grey,
      ),
    );
  }
}
