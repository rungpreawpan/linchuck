import 'package:flutter/material.dart';
import 'package:lin_chuck/widget/custom_app_bar.dart';
import 'package:lin_chuck/widget/custom_drawer.dart';
import 'package:lin_chuck/widget/custom_side_bar.dart';

class MainTemplate extends StatefulWidget {
  final String appBarTitle;
  final double bottomPadding;
  final bool showBackButton;
  final bool showActionButton;
  final Widget actionButton;
  final List<Widget> contentWidget;
  final Function()? backFunction;

  const MainTemplate({
    super.key,
    required this.appBarTitle,
    this.bottomPadding = 30.0,
    this.showBackButton = false,
    this.showActionButton = false,
    this.actionButton = const SizedBox(),
    required this.contentWidget,
    this.backFunction,
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
            bottomPadding: widget.bottomPadding,
            showBackIcon: widget.showBackButton,
            showActionButton: widget.showActionButton,
            actionButton: widget.actionButton,
            backFunction: widget.backFunction,
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
