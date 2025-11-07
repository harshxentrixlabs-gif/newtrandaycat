
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_color.dart';
import '../app_icons.dart';
import 'app_image.dart';
import 'app_text.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool isGradiantText;
  final bool showBack;
  final PreferredSizeWidget? bottom;

  const AppAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.bottom,
    this.centerTitle = true,
    this.isGradiantText = false,
    this.showBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      toolbarTextStyle: TextStyle(color: Colors.black),
      automaticallyImplyLeading: false,
      bottom: bottom,
      leading: showBack
          ? Padding(
            padding: const EdgeInsets.only(left: 10,),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.5),
                shape: BoxShape.circle
              ),
              child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
            ),
          )
          : null,leadingWidth: 50,
      title: AppText(
        title,
        // style: const TextStyle(
          color: AppColor.textBlack,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        // ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      // flexibleSpace: Container(
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage(AppImages.appBarBg),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


