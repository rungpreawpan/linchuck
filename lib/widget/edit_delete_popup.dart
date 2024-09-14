import 'package:flutter/material.dart';
import 'package:lin_chuck/constant/value_constant.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class EditDeletePopup extends StatefulWidget {
  final String selectedItem;
  final Function() onEdit;
  final Function() onDelete;

  const EditDeletePopup({
    super.key,
    required this.selectedItem,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<EditDeletePopup> createState() => _EditDeletePopupState();
}

class _EditDeletePopupState extends State<EditDeletePopup> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();

    selectedItem = widget.selectedItem;
  }

  List<String> popupItems = ['แก้ไข', 'ลบ'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) {
        selectedItem = item.toString();

        setState(() {});
      },
      itemBuilder: (BuildContext context) {
        return popupItems.map((data) {
          return PopupMenuItem<String>(
            value: data,
            child: InkWell(
              onTap: data == 'แก้ไข' ? widget.onEdit : widget.onDelete,
              child: Row(
                children: [
                  Icon(
                    data == 'แก้ไข'
                        ? Icons.edit_rounded
                        : Icons.delete_forever_rounded,
                  ),
                  const SizedBox(width: marginX2),
                  TextFontStyle(
                    data,
                    size: fontSizeM,
                  ),
                ],
              ),
            ),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      offset: const Offset(-5, 30),
      child: const Icon(Icons.more_vert_rounded),
    );
  }
}
