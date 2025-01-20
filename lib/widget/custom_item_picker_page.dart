import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/custom_submit_button.dart';
import 'package:lin_chuck/widget/custom_text_field.dart';
import 'package:lin_chuck/widget/main_template.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class CustomItemPicker extends StatefulWidget {
  final String title;
  final String? hintText;
  final double? hintSize;
  final List items;
  final Widget Function(dynamic item, bool isSelected) itemWidget;
  final dynamic Function(String searchText) onSearch;
  final int maximumItem;
  final bool pickMultipleItem;
  final List selectedItems;
  final bool enabledSelect;
  final bool showConfirmButton;

  const CustomItemPicker({
    super.key,
    required this.title,
    this.hintText,
    this.hintSize,
    required this.items,
    required this.itemWidget,
    required this.onSearch,
    this.maximumItem = 99,
    this.pickMultipleItem = true,
    required this.selectedItems,
    this.enabledSelect = true,
    this.showConfirmButton = true,
  });

  @override
  State<CustomItemPicker> createState() => _CustomItemPickerState();
}

class _CustomItemPickerState extends State<CustomItemPicker> {
  final TextEditingController _searchController = TextEditingController();
  List _filteredItems = [];

  late StreamSubscription<bool> _keyboardSubscription;
  bool _keyboardIsVisible = false;
  late int _maximumItem;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;

    if (widget.pickMultipleItem) {
      _maximumItem = widget.maximumItem;
    } else {
      _maximumItem = 1;
    }

    _keyboardSubscription = KeyboardVisibilityController().onChange.listen(
      (bool visible) {
        _keyboardIsVisible = visible;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _keyboardSubscription.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.keyboard_arrow_left_rounded,
            color: Colors.black,
            size: 40.0,
          ),
        ),
        title: TextFontStyle(
          widget.title,
          size: 30.0,
          weight: FontWeight.bold,
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.0,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          _searchBar(),
          const SizedBox(height: margin),
          Expanded(
            child: _dataList(),
          ),
          const SizedBox(height: margin),
          _confirmButton(),
        ],
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(marginX2),
      child: CustomTextField(
        textEditingController: _searchController,
        hintText: widget.hintText,
        onChanged: (value) {
          _filteredItems = widget.onSearch(value);
          setState(() {});
        },
      ),
    );
  }

  _dataList() {
    return _filteredItems.isNotEmpty
        ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: marginX2),
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              var item = _filteredItems[index];
              bool isSelected = widget.selectedItems.contains(item);

              return InkWell(
                onTap: widget.enabledSelect
                    ? () {
                        if (isSelected) {
                          widget.selectedItems.remove(item);
                        } else {
                          if (widget.pickMultipleItem) {
                            if (widget.selectedItems.length < _maximumItem) {
                              widget.selectedItems.insert(0, item);
                            }
                          } else {
                            widget.selectedItems.clear();
                            widget.selectedItems.add(item);
                          }
                        }

                        setState(() {});
                      }
                    : null,
                child: widget.itemWidget(
                  item,
                  isSelected,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: marginX2);
            },
          )
        : const Padding(
            padding: EdgeInsets.all(20.0),
            child: TextFontStyle(
              'ไม่พบข้อมูล',
              size: fontSizeL,
            ),
          );
  }

  _confirmButton() {
    bool enabled = widget.selectedItems.isNotEmpty;

    return Visibility(
      visible: widget.showConfirmButton && !_keyboardIsVisible,
      child: SafeArea(
        child: enabled
            ? CustomSubmitButton(
                onTap: () {
                  Get.back(result: widget.selectedItems);
                },
                title: 'ยืนยัน',
                fontSize: fontSizeM,
                borderRadius: 10,
                backgroundColor: primaryColor,
              )
            : CustomSubmitButton(
                onTap: () {},
                title: 'ยืนยัน',
                fontSize: fontSizeM,
                borderRadius: 10,
                backgroundColor: Colors.transparent,
                fontColor: Colors.grey.shade400,
                showBorder: true,
                borderColor: Colors.grey.shade400,
                borderWidth: 1.5,
              ),
      ),
    );
  }
}
