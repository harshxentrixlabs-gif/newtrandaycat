import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/login_screen/login_screen.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/commons.dart';
import 'controller/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController splashScreenController = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    appPrint("SplashScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05,
          vertical: Get.height * 0.07,
        ),
        child: Column(
          children: [
            Expanded(child: commonImage()),
            SizedBox(height: Get.height * 0.02),
            commonDotsIndicator(),
          ],
        ),
      ),
    );
  }

  Widget commonImage() {
    return PageView.builder(
      controller: splashScreenController.controller,
      itemCount: splashScreenController.imageList.length,
      onPageChanged: (index) {
        splashScreenController.dotsIndicator.value = index;
      },
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: AppImage.network(
                  height: Get.height * 0.55,
                  width: double.infinity,
                  splashScreenController.imageList[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Expanded(
              child: AppText(
                splashScreenController.textLis[index],
                fontSize: Get.height * 0.030,
                color: AppColor.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Flexible(
              child: AppText(
                splashScreenController.textLisSeconde[index],
                fontSize: Get.height * 0.018,
                color: AppColor.primary.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget commonDotsIndicator() {
    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DotsIndicator(
            dotsCount: splashScreenController.imageList.length,
            position: splashScreenController.dotsIndicator.value.toDouble(),
            decorator: DotsDecorator(
              color: Colors.grey.shade400,
              activeColor: AppColor.primary,
              size: const Size.square(9.0),
              activeSize: const Size(25.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primary,
            ),
            child: IconButton(
              onPressed: () {
                if (splashScreenController.dotsIndicator.value <
                    splashScreenController.imageList.length - 1) {
                  splashScreenController.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Get.off(() => const LoginScreen());
                }
              },
              icon: Icon(Icons.arrow_forward, color: AppColor.textWhite),
            ),
          ),
        ],
      ),
    );
  }
}
