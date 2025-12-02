import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/view/forgot_password/controller/forgot_controller.dart';

import '../../utils/common_font.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final PageController pageController = PageController();
  final ForgotController forgotController = Get.put(ForgotController());

  int currentPage = 0;

  void goNextPage() {
    if (forgotController.currentPage.value < 4) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      AppLogs.log("Form Completed ✔");
      // TODO: Next Screen Navigation
      // Get.toNamed("/seller-success");
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (forgotController.currentPage.value > 0) {
          pageController.previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppAppBar(title: AppString.confirmPassword,onBack: () {
          if (forgotController.currentPage.value > 0) {
            pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            Get.back();
          }
        },),
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
            child: CommonBlackButton(title: forgotController.currentPage.value == 0
            ? "Continue" : "FINISH",  onTap: goNextPage),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.040,
            vertical: Get.height * 0.030,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (i) {
                    forgotController.currentPage.value = i;
                  },
                  children:  [
                    ConfirmPassword1(),
                    ConfirmPassWord2()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmPassword1 extends StatefulWidget {
  const ConfirmPassword1({super.key});

  @override
  State<ConfirmPassword1> createState() => _ConfirmPassword1State();
}

class _ConfirmPassword1State extends State<ConfirmPassword1> {
  @override
  Widget build(BuildContext context) {
    final ForgotController forgotController = Get.put(ForgotController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  AppImage.svg(AppIcons.nullImages),
                  SizedBox(width: Get.width * 0.020),
                  Expanded(
                    child: AppText(
                      AppString
                          .weWillSendTheOTPCodeToYourEmailForSecurityInForgettingYourPassword,
                      fontSize: Get.height * 0.012,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.06),
          AppText("Email", fontSize: Get.height * 0.012,fontFamily: AppFont.semiBold,),
          SizedBox(height: Get.height * 0.010),
          CommonTextField(
            controller: forgotController.emailController,
            hintText: "Email",
          ),
        ],
      ),
    );
  }
}


class ConfirmPassWord2 extends StatefulWidget {
  const ConfirmPassWord2({super.key});

  @override
  State<ConfirmPassWord2> createState() => _ConfirmPassWord2State();
}

class _ConfirmPassWord2State extends State<ConfirmPassWord2> {
  final ForgotController forgotController = Get.put(ForgotController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(AppString.newPassword, fontSize: Get.height * 0.014,fontWeight: FontWeight.normal,fontFamily: AppFont.semiBold,
          ),
          SizedBox(height: Get.height * 0.010),
          Obx(
                () => CommonTextField(
              controller: forgotController.newPasswordController,
              hintText: AppString.newPassword,
              obscureText: forgotController.isNewPasswordVisible.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppString.newPassword;
                }
                return null;
              },
              suffixIcon: IconButton(
                icon: Icon(
                  forgotController.isNewPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  forgotController.newPasswordVisible();
                },
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.020),
          AppText(AppString.confirmPassword, fontSize: Get.height * 0.014,fontWeight: FontWeight.normal,fontFamily: AppFont.semiBold),
          SizedBox(height: Get.height * 0.010),
          Obx(
                () => CommonTextField(
              controller: forgotController.confirmPasswordController,
              hintText: AppString.confirmPassword,
              obscureText:
              forgotController.isNewConfirmPasswordVisible.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppString.confirmPassword;
                }
                return null;
              },
              suffixIcon: IconButton(
                icon: Icon(
                  forgotController.isNewConfirmPasswordVisible.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  forgotController.newConfirmPasswordVisible();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
