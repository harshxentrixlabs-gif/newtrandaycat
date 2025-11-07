import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_text.dart';

import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/common_appbar.dart';
import '../navigation_menu/controller/navigation_controller.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {

  NavigationController navigationController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar:  CommonAppBar(
        name: "Harsh",
        subName: "Flutter Developer",
        images:
        "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.05),
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: Get.height * 0.040,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppImage.svg(AppIcons.search),
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.040),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: Get.height * 0.040,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppImage.svg(AppIcons.notification),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ], onTap: () {
          navigationController.changeIndex(4);
      },
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.030,vertical: Get.height * 0.015),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(AppString.wishlistCollection,fontSize: Get.height * 0.018,fontWeight: FontWeight.bold,),
          ],
        ),
      ),
    );
  }
}
