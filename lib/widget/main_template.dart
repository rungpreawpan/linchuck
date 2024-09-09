import 'package:flutter/material.dart';
import 'package:lin_chuck/widget/custom_app_bar.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/widget/custom_side_bar.dart';

class MainTemplate extends StatefulWidget {
  final String appBarTitle;
  final bool showBackButton;
  final List<Widget> contentWidget;

  const MainTemplate({
    super.key,
    required this.appBarTitle,
    this.showBackButton = false,
    required this.contentWidget,
  });

  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: const CustomDrawer(),
      body: _body(),
    );
  }

  _body() {
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
            _content(),
          ],
        ),
      ),
    );
  }

  _content() {
    return Expanded(
      child: Column(
        children: [
          CustomAppBar(
            title: widget.appBarTitle,
            showBackIcon: widget.showBackButton,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.contentWidget,
            ),
          ),
        ],
      ),
    );
  }
}
