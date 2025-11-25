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
      iconTheme: const IconThemeData(color: Colors.black),
      toolbarTextStyle: const TextStyle(color: Colors.black),
      automaticallyImplyLeading: false,
      bottom: bottom,
       backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      /// -----------------------------------
      /// 🔙 Leading Back Icon (Perfect Center)
      /// -----------------------------------
      leading: showBack
          ? Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                  size: 18,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ),
      )
          : null,
      leadingWidth: 50,

      /// ----------------------------
      /// 🔤 Title
      /// ----------------------------
      title: AppText(
        title,
        color: AppColor.textBlack,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),

      centerTitle: centerTitle,

      /// ----------------------------
      /// 📌 Actions (Right Icons)
      /// ----------------------------
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
