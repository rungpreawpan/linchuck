import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lin_chuck/constant/value_constant.dart';

class TemplateBackground extends StatelessWidget {
  final AppBar? appBar;
  final Widget body;

  const TemplateBackground({
    super.key,
    this.appBar,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: appBar,
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
