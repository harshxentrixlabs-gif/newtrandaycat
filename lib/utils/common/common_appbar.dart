import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'app_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.name,

    this.actions,
    this.bottom, required this.onTap, required this.image,
  });

  final String name;
  final String image;
  final Function() onTap;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: bottom,
      title: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(width: Get.width * 0.020),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(name, fontSize: Get.height * 0.022, fontWeight: FontWeight.bold),
                    AppImage.svg(image)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
