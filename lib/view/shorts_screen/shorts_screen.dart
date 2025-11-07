import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:video_player/video_player.dart';

import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';
import '../splash_screen/controller/splash_screen.dart';
import 'controller/shorts_controller.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {

  final ShortsController controller = Get.put(ShortsController());



  SplashScreenController splashScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ShortsController>(
        builder: (controller) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: splashScreenController.controller,
            itemCount: controller.videoUrls.length,
            onPageChanged: (index) {
              splashScreenController.dotsIndicator.value = index;
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  InkWell(
                    onTap: controller.togglePlayPause,
                    child: controller.videoController.value.isInitialized
                        ? VideoPlayer(controller.videoController)
                        :  Center(child: CircularProgressIndicator()),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AppText(
                              'User Info & Caption',
                              color: AppColor.primary,
                              fontSize: Get.height * 0.010,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.010),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1, color: Colors.black),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Container(
                                  width: Get.width * 0.09,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                        stackTrace) =>
                                        Icon(Icons.person, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width * 0.020),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppText(
                                      "Harsh",
                                      fontSize: Get.height * 0.015,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textWhite,
                                    ),
                                    SizedBox(width: Get.width * 0.020),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                            alpha: 0.3),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        child: AppText(
                                          'Follow',
                                          color: Colors.white,
                                          fontSize: Get.height * 0.009,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                AppText(
                                  "Flutter Developer",
                                  fontSize: Get.height * 0.012,
                                  color: AppColor.textWhite,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.010),
                        AppText(
                          'User Info & Caption,huhehjfhsvdsddf.',
                          color: Colors.white,
                          fontSize: Get.height * 0.014,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Get.height * 0.10,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0, top: 8),
                                child: Container(
                                  width: Get.width * 0.65,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: AppImage.network(
                                            width: Get.width * 0.14,
                                            height: Get.height * 0.14,
                                            'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.030),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: AppText(
                                                  "Hello",
                                                  color: AppColor.textWhite,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Expanded(
                                                child: AppText(
                                                  "Hello madfnsjdn sdsdf jkdshfisdfhisdfsdjfhsiofdjfoisuh",
                                                  color: AppColor.textWhite,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  fontSize: Get.height * 0.010,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    AppText(
                                                      "\$ 300",
                                                      color: AppColor.primary,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColor.primary,
                                                        borderRadius:
                                                        BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .only(left: 15.0,
                                                            right: 15,
                                                            top: 2,
                                                            bottom: 2),
                                                        child: AppText(
                                                          AppString.byNow,
                                                          color: AppColor
                                                              .textWhite,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          fontSize: Get.height *
                                                              0.012,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 150,
                    right: 20,
                    child: Column(
                      children: [
                        commonButton(Icons.favorite_border, () {}),
                        SizedBox(height: 10),
                        commonButton(Icons.share, () {}),
                        SizedBox(height: 10),
                        commonButton(Icons.more_vert, () {}),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }
      ),
    );
  }

  Widget commonButton(IconData icon, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
