import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.name,
    required this.subName,
    required this.images,
    this.actions,
    this.bottom, required this.onTap,
  });

  final String name;
  final String subName;
  final String images;
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
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: Padding(
                padding:  EdgeInsets.all(2.0),
                child: Container(
                  width: Get.width * 0.09,
                  height: 40,
                  clipBehavior: Clip.antiAlias,
                  decoration:  BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    images,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: Get.width * 0.020),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(name, fontSize: Get.height * 0.015, fontWeight: FontWeight.bold),
                AppText(subName, fontSize: Get.height * 0.012, color: Colors.grey),
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
