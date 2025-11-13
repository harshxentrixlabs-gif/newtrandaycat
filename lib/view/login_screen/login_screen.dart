import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/home_screen/home_screen.dart';
import 'package:trendycart/view/login_screen/controller/login_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/app_loader.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_loader.dart';
import '../../utils/common/app_textfield.dart';
import '../../utils/common/common_line.dart';
import '../../utils/common/widgets.dart';
import '../../utils/commons.dart';
import '../mobile_screen/mobile_screen.dart';
import '../navigation_menu/navigation_menu.dart';
import '../sign_up_screen/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AppLogs.log("Login Screen");
    loginController.clearText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>   Stack(
        children: [
          Column(
            children: [
              Container(
                height: Get.height * 0.40,
                width: double.infinity,
                decoration: BoxDecoration(color: AppColor.primary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      AppString.hiWelcomeBack,
                      fontSize: Get.height * 0.030,
                      color: AppColor.textWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: Get.height * 0.010),
                    AppText(
                      AppString.singleIntoAccessYourAccount,
                      fontSize: Get.height * 0.018,
                      color: AppColor.textWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Get.height * 0.30,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.030,
                  vertical: Get.height * 0.030,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(AppString.email),
                        SizedBox(height: Get.height * 0.010),
                        CommonTextField(
                          controller: loginController.emailController,
                          hintText: AppString.enterYourEmailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please Enter Email';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'please Enter valid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: Get.height * 0.030),
                        CommonButton(
                          title: AppString.continueWithEmail,
                          color: AppColor.primary,
                          onTap: () {
                            AppLogs.log("Continue login...");
                            if (_formKey.currentState!.validate()) {
                              // loginController.loginMethod();
                              AppLogs.log(" Continue login...");
                            } else {
                              AppLogs.log("Validation failed");
                            }
                          },
                        ),
                        SizedBox(height: Get.height * 0.040),
                        commonRow(),
                        SizedBox(height: Get.height * 0.040),
                        CommonButton(
                          onTap: () {
                            AppLogs.log(AppString.demoLogin);
                            loginController.showDialog(
                              onTap: () {
                                loginController.googleLogin();
                                // Get.offAll(
                                //   () => NavigationMenu(),
                                //   transition: Transition.rightToLeft,
                                // );
                              },
                            );
                          },
                          title: AppString.demoLogin,
                          image: AppIcons.rocket,
                        ),
                        SizedBox(height: Get.height * 0.020),
                        Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                onTap: () {
                                  AppLogs.log("Login mobile");
                                  Get.to(
                                    () => MobileScreen(),
                                    transition: Transition.rightToLeft,
                                  );
                                },
                                title: AppString.mobileLogin,
                                image: AppIcons.phone,
                              ),
                            ),
                            SizedBox(width: Get.width * 0.020),
                          Expanded(
                              child:loginController.isLoading.value ? Center(child: AppLoaderWidget()) : CommonButton(
                                onTap: () {
                                  AppLogs.log("Google Login");
                                  loginController.googleLogin();
                                },
                                title: AppString.googleLogin,
                                image: AppIcons.google,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.030),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: AppText(
                                AppString.doNotHaveAccount,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: Get.width * 0.020),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => SignUpScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: AppText(
                                AppString.signUp,
                                color: AppColor.textBlack,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.030),
                        CommonButton(
                          title: AppString.sellerDemoAccount,
                          onTap: () {
                            AppLogs.log("Seller Demo Account");
                            loginController.showDialog(onTap: () {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      )
    );
  }

  Widget commonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: CustomLine()),
        SizedBox(width: Get.width * 0.040),
        AppText(AppString.orContinueWith),
        Divider(color: AppColor.textBlack),
        SizedBox(width: Get.width * 0.040),
        Expanded(child: CustomLine()),
      ],
    );
  }
}
