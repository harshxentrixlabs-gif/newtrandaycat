import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../app_color.dart';
import '../app_icons.dart';
import '../common_font.dart';
import 'app_image.dart';
import 'app_text.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool isGradiantText;
  final bool showBack;
  final PreferredSizeWidget? bottom;
  final Function()? onBack;

  const AppAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.onBack,
    this.bottom,
    this.centerTitle = true,
    this.isGradiantText = false,
    this.showBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xffffdabe),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarTextStyle: const TextStyle(color: Colors.black),
        automaticallyImplyLeading: false,
        bottom: bottom,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      
        leading: showBack
            ? Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
            child: GestureDetector(
              onTap: () {
                if (onBack != null) {
                  onBack!();
                } else {
                  Get.back();
                }
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
        )
            : null,
      
        title: AppText(
          title,
          color: AppColor.textBlack,
          fontSize: 18,
            fontFamily: AppFont.semiBold
        ),
      
        centerTitle: centerTitle,
      
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
