import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/view/help_supports/help_support.dart';
import 'package:trendycart/view/login_screen/controller/login_controller.dart';
import 'package:trendycart/view/login_screen/login_screen.dart';
import 'package:trendycart/view/secutity_screen/security_screen.dart';

import '../../app_string/app_string.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_text.dart';
import '../profile_screen/widget/profile_container_common.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.setting),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.030,
          vertical: Get.height * 0.020,
        ),
        child: Column(
          children: [
            ProfileContainerCommon(
              images: AppIcons.language,
              title: AppString.language,
              onTap: () {
                AppLogs.log(AppString.language);
              },
            ),
            SizedBox(height: Get.height * 0.015),
            ProfileContainerCommon(
              images: AppIcons.security,
              title: AppString.security,
              onTap: () {
                AppLogs.log(AppString.security);
                Get.to(
                  () => SecurityScreen(),
                  transition: Transition.rightToLeft,
                );
              },
            ),
            SizedBox(height: Get.height * 0.015),
            ProfileContainerCommon(
              images: AppIcons.auction,
              title: AppString.legalAndPolicies,
              onTap: () {
                AppLogs.log(AppString.legalAndPolicies);
                Get.to(
                  () => SecurityScreen(),
                  transition: Transition.rightToLeft,
                );
              },
            ),
            SizedBox(height: Get.height * 0.015),
            ProfileContainerCommon(
              images: AppIcons.help,
              title: AppString.helpAndSupport,
              onTap: () {
                AppLogs.log(AppString.helpAndSupport);
                Get.to(() => HelpSupport(), transition: Transition.rightToLeft);
              },
            ),
            SizedBox(height: Get.height * 0.015),
            ProfileContainerCommon(
              images: AppIcons.logout,
              title: AppString.logout,
              onTap: () {
                AppLogs.log(AppString.logout);
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 30,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText(
                                AppString.logOutAccount,
                                color: AppColor.textBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              CommonButton(
                                onTap: () {
                                  Get.back();
                                },
                                title: AppString.cancel,
                              ),
                              SizedBox(height: 15),
                              InkWell(
                                onTap: (){
                                  loginController.logout();
                                  Get.offAll(()=>LoginScreen(),
                                    transition: Transition.rightToLeft
                                  );
                                },
                                child: AppText(
                                  AppString.logout,
                                  fontSize: Get.height * 0.020,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  barrierDismissible: false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
