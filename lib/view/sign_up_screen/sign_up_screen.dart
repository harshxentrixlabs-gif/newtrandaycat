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
import '../../utils/common/app_appbar.dart';

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
      appBar: AppAppBar(title: AppString.signUp),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.050,
          vertical: Get.height * 0.050,
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
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: Get.height * 0.010),
                    AppText(
                      AppString.fillInYourDetailsToCreateYourAccount,
                      fontSize: Get.width * 0.025,
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



  Widget commonContinue({required Function() onTap, required String title}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height * 0.055,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: AppText(
            title,
            color: AppColor.textWhite,
            fontWeight: FontWeight.bold,
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
          SizedBox(height: Get.height * 0.050),
          AppText(AppString.firstName),
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
          AppText(AppString.email),
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
          AppText(AppString.password),
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
          AppText(AppString.confirmPassword),
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
            if (_formKey.currentState!.validate()) {
              appPrint(" Continue login...");
            } else {
              appPrint(" Validation failed");
            }
          }, title: AppString.signUp),
          SizedBox(height: Get.height * 0.030),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(AppString.alreadyHaveAnAccount),
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
                    fontWeight: FontWeight.bold,
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
