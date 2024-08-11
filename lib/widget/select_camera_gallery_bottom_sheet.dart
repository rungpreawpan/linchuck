import 'package:flutter/material.dart';
import 'package:lin_chuck/widget/text_font_style.dart';

class SelectCameraGalleryBottomSheet extends StatelessWidget {
  final Function() getImageFromCamera;
  final Function() getImageFromGallery;

  const SelectCameraGalleryBottomSheet({
    super.key,
    required this.getImageFromCamera,
    required this.getImageFromGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _card(
              onTap: getImageFromCamera,
              icon: Icons.camera_alt_rounded,
              title: 'กล้อง',
            ),
            _card(
              onTap: getImageFromGallery,
              icon: Icons.photo,
              title: 'แกลเลอรี่',
            ),
          ],
        ),
      ),
    );
  }

  _card({
    required Function() onTap,
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: TextFontStyle(title),
    );
  }
}
