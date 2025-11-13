import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:video_player/video_player.dart';

import '../../utils/common/app_image.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  TextEditingController textEditingController = TextEditingController();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
          ..initialize().then((_) {
            setState(() {});
            _controller.play();
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(_controller),
          Positioned(
            bottom: 150,
            right: 20,
            top: 45,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 150,
            right: 20,
            top: 45,
            left: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width * 0.30,
                  height: Get.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.black.withValues(alpha: 0.20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 3.0,
                      right: 3,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              width: Get.width * 0.09,
                              height: 30,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.person, color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: AppText(
                                  "Harsh Shiroya",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: Get.height * 0.012,
                                  color: AppColor.textWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: AppText(
                                  "Hello Guys Welcome",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: Get.height * 0.010,
                                  color: AppColor.textWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 45,
            left: 210,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width * 0.27,
                  height: Get.height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.black.withValues(alpha: 0.20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 3,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_red_eye, color: Colors.white),
                        SizedBox(width: 5),
                        AppText(
                          "50K",
                          overflow: TextOverflow.ellipsis,
                          fontSize: Get.height * 0.012,
                          color: AppColor.textWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 3,
                                bottom: 3,
                              ),
                              child: Center(
                                child: AppText(
                                  "Live",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: Get.height * 0.012,
                                  color: AppColor.textWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.010),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: Colors.black,
                    style: TextStyle(color: AppColor.textBlack, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Write here...",
                      hintStyle: TextStyle(
                        color: AppColor.textSecondary,
                        fontSize: 13,
                      ),
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: AppImage.svg(
                              AppIcons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ),
                      filled: true,
                      fillColor: AppColor.background,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: AppImage.network(
                        "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
                        height: 60,
                        width: 60,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.009),
                    AppText(
                      "Shop",
                      color: Colors.white,
                      fontSize: Get.height * 0.010,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
