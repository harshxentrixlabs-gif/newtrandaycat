import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/common/app_text.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();



  void clearText() {
    emailController.clear();
  }

  void showDialog({required Function() onTap})
  {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              padding:  EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.success,
                  color: Colors.white,
                  height: 80,
                  width:80,
                ),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                   AppString.youHveLoggedInSuccessfully,
                    color:AppColor.textBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,

                  ),
                  SizedBox(height: 10),
                  AppText(
                    AppString.accessTOYou,
                    color: Colors.grey,
                    fontSize: 12,
                    textAlign: TextAlign.center,

                  ),
                  SizedBox(height: 20),
                  CommonButton(
                    onTap: onTap,
                    title: AppString.continueButton,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }



}
