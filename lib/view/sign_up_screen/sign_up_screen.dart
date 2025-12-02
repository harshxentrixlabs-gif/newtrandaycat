import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/utils/commons.dart';
import 'package:trendycart/view/login_screen/login_screen.dart';
import 'package:trendycart/view/sign_up_screen/controller/sign_up_controller.dart';

import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_appbar.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common_font.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signUpController.clearText();
    appPrint("[SignUpScreen]");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.signUp),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.050,
          vertical: Get.height * 0.030,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    AppText(
                      AppString.completeYourAccount,
                      fontSize: Get.width * 0.040,
                        fontFamily: AppFont.bold,
                    ),
                    SizedBox(height: Get.height * 0.010),
                    AppText(
                      AppString.fillInYourDetailsToCreateYourAccount,
                      fontSize: Get.width * 0.025,
                      fontFamily: AppFont.regular,
                    ),
                  ],
                ),
              ),
              commonForm(),
            ],
          ),
        ),
      ),
    );
  }




  Widget commonForm(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * 0.030),
          AppText(AppString.firstName,fontFamily: AppFont.semiBold,),
          SizedBox(height: Get.height * 0.010),
          CommonTextField(
            controller: signUpController.nameController,
            hintText: AppString.enterYourFirstName,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppString.pleaseEnterName;
              }
              return null;
            },
          ),
          SizedBox(height: Get.height * 0.030),
          AppText(AppString.email,fontFamily: AppFont.semiBold),
          SizedBox(height: Get.height * 0.010),
          CommonTextField(
            controller: signUpController.emailController,
            hintText: AppString.enterYourEmailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppString.pleaseEnterEmail;
              } else if (!GetUtils.isEmail(value)) {
                return AppString.pleaseEnterValidEmail;
              }
              return null;
            },
          ),
          SizedBox(height: Get.height * 0.030),
          AppText(AppString.password,fontFamily: AppFont.semiBold),
          SizedBox(height: Get.height * 0.010),
          Obx(() => CommonTextField(
            controller: signUpController.passwordController,
            hintText: AppString.enterYourPassword,
            obscureText: signUpController.isPasswordVisible.value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppString.pleaseEnterPassword;
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                signUpController.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                signUpController.passwordVisible();
              },
            ),
          ),
          ),
          SizedBox(height: Get.height * 0.030),
          AppText(AppString.confirmPassword,fontFamily: AppFont.semiBold),
          SizedBox(height: Get.height * 0.010),
          Obx(() => CommonTextField(
            controller: signUpController.confirmPasswordController,
            hintText: AppString.enterYourPassword,
            obscureText: signUpController.isConfirmPasswordVisible.value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppString.pleaseEnterConfirmPassword;
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                signUpController.isConfirmPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                signUpController.confirmPasswordVisible();
              },
            ),
          ),
          ),
          SizedBox(height: Get.height * 0.030),
          CommonButton(onTap: () {
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
                        vertical: 15,
                      ),
                      child: Column(
                        children: [
                          AppImage.svg(AppIcons.successSignUp),
                          SizedBox(height: 10),
                          AppText(
                            "You have logged in successfully",
                            color: AppColor.textBlack,
                            fontSize: 20,
                            fontFamily: AppFont.bold,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          AppText(
                            "Access to your secure account has been granted. Your data is protected with end to-end encryption",
                            color: Colors.grey,
                            fontSize: 16,
                            fontFamily: AppFont.semiBold,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 15),
                          CommonBlackButton(
                            onTap: () {
                              Get.back();
                            },
                            title: "Continue",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              barrierDismissible: false,
            );
            // if (_formKey.currentState!.validate()) {
            //   appPrint(" Continue login...");
            //
            // } else {
            //   appPrint(" Validation failed");
            // }
          }, title: AppString.signUp),
          SizedBox(height: Get.height * 0.030),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(AppString.alreadyHaveAnAccount,fontFamily: AppFont.medium),
              SizedBox(width: Get.width * 0.020),
              Flexible(
                child: InkWell(
                  onTap: () {
                    Get.off(() => LoginScreen(),
                      transition: Transition.rightToLeft,
                      duration:  Duration(milliseconds: 400),
                    );
                  },
                  child: AppText(
                    "Sign In",
                    overflow: TextOverflow.ellipsis,
                    color: AppColor.textBlack,
                    fontFamily: AppFont.semiBold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
