import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/view/forgot_password/controller/forgot_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final ForgotController forgotController = Get.put(ForgotController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.confirmPassword),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.050,
          vertical: Get.height * 0.030,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(Icons.ac_unit_sharp),
                    SizedBox(width: Get.width * 0.020),
                    Expanded(
                      child: AppText(
                        AppString.weWillSendTheOTPCodeToYourEmailForSecurityInForgettingYourPassword,
                        fontSize: Get.height * 0.012,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.06,),
            AppText("Email",fontSize: Get.height * 0.012,),
            SizedBox(height: Get.height * 0.010,),
            CommonTextField(controller: forgotController.emailController, hintText: "Email"),
            Spacer(),
            CommonButton(title: AppString.submit)
          ],
        ),
      ),
    );
  }
}
