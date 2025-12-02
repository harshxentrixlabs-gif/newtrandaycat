    import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/login_screen/login_screen.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common_font.dart';
import 'controller/splash_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final SplashScreenController splashScreenController =
  Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        return Stack(
          children: [
            PageView.builder(
              controller: splashScreenController.controller,
              itemCount: splashScreenController.imageList.length,
              onPageChanged: (index) {
                splashScreenController.dotsIndicator.value = index;
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  splashScreenController.imageList[index],
                  height: Get.height,
                  width: Get.width,
                  fit: BoxFit.cover,
                );
              },
            ),

            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DotsIndicator(
                    dotsCount: splashScreenController.imageList.length,
                    position: splashScreenController.dotsIndicator.value.toDouble(),
                    decorator: DotsDecorator(
                      color: Colors.white38,
                      activeColor: AppColor.textWhite,
                      size:  Size(28.0, 5.0),
                      activeSize:  Size(28.0, 5.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: AppText(
                      splashScreenController.textLis[
                      splashScreenController.dotsIndicator.value],
                      fontSize: Get.height * 0.030,
                      color:AppColor.textWhite,
                      fontFamily: AppFont.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: AppText(splashScreenController.textLisSeconde[splashScreenController.dotsIndicator.value],
                      fontSize: Get.height * 0.015,
                      color:AppColor.textWhite,
                      fontFamily: AppFont.regular,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100), // Rounded corners
                              ),
                            ),
                            onPressed: (){
                          if (splashScreenController.dotsIndicator.value <
                              splashScreenController.imageList.length - 1) {
                            splashScreenController.controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Get.off(() => const LoginScreen());
                          }
                        }, child: AppText(splashScreenController.dotsIndicator.value == 2 ? "GET STARTED" :"NEXT", fontFamily: AppFont.bold,)),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
