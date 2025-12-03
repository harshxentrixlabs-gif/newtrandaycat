import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common_font.dart';
import 'app_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.name,
    this.image = "",
    this.onTap,
    this.actions,
    this.bottom,
  });

  final String name;
  final String image;
  final Function()? onTap;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      bottom: bottom,
      title: Center(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                name,
                fontSize: Get.height * 0.022,
                fontFamily: AppFont.semiBold,
              ),

              /// ⭐ Only show image if provided
              if (image.isNotEmpty) ...[
                SizedBox(width: 6),
                AppImage.svg(
                  image,
                  height: 20,
                ),
              ],
            ],
          ),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
