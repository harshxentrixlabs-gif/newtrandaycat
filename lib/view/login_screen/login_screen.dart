import 'dart:developer' as AppLogs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/login_screen/controller/login_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/app_loader.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_loader.dart';
import '../../utils/common/app_textfield.dart';
import '../../utils/common/common_line.dart';
import '../../utils/common/widgets.dart';
import '../../utils/common_font.dart';
import '../mobile_screen/mobile_screen.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(
            () => SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                /// *** Header Image + Welcome Text Overlap ***
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: Get.height * 0.33,
                      width: double.infinity,
                      child: Image.asset(
                        AppIcons.login,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -Get.height * 0.00,
                      left: Get.width * 0.05,
                      right: Get.width * 0.05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Row(
                          children: [
                             AppText("Trendycart", fontFamily: AppFont.bold,fontSize: Get.height * 0.03,),
                            AppImage.svg(AppIcons.loginIcons)
                           ],
                         ),
                          AppText(
                            AppString.hiWelcomeBack,
                            fontSize: Get.height * 0.030,
                            fontFamily: AppFont.bold,
                            color: AppColor.textBlack,
                          ),
                          SizedBox(height: Get.height * 0.010),
                          AppText(
                            AppString.singleIntoAccessYourAccount,
                            fontSize: Get.height * 0.014,
                            color: Colors.grey,
                              fontFamily: AppFont.medium
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.050),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(AppString.email, fontFamily: AppFont.bold,),
                      SizedBox(height: Get.height * 0.010,),

                      CommonTextField(
                        controller: loginController.emailController,
                        hintText: AppString.enterYourEmailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: Get.height * 0.030),
                      CommonButton(
                        title: AppString.continueWithEmail,
                        color: AppColor.primary,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            AppLogs.log("Continue login...");
                          }
                        },
                      ),

                      SizedBox(height: Get.height * 0.040),
                      commonRow(),
                      SizedBox(height: Get.height * 0.040),
                      OutlineWhiteButton(
                        onTap: () {
                          AppLogs.log(AppString.demoLogin);
                        },
                        text: AppString.demoLogin,
                      ),
                      SizedBox(height: Get.height * 0.020),
                      Row(
                        children: [
                          Expanded(
                            child: OutlineWhiteButton(
                              onTap: () {
                                Get.to(
                                      () => MobileScreen(),
                                  transition: Transition.rightToLeft,
                                );
                              },
                              image: AppIcons.phone, text: AppString.mobileLogin,
                            ),
                          ),
                          SizedBox(width: Get.width * 0.020),
                          Expanded(
                            child: loginController.isLoading.value
                                ? Center(child: AppLoaderWidget())
                                : OutlineWhiteButton(
                              onTap: () {
                                loginController.googleLoginAndApiCall();
                              },
                              text: AppString.googleLogin,
                              image: AppIcons.google,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: Get.height * 0.030),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(AppString.doNotHaveAccount,color: Colors.grey,),
                          SizedBox(width: 6),
                          InkWell(
                            onTap: () {
                              Get.to(() => SignUpScreen());
                            },
                            child: AppText(
                              AppString.signUp,
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: Get.height * 0.030),
                      CommonBlackButton(
                        title: AppString.sellerDemoAccount,
                        onTap: () {},
                      ),
                      SizedBox(height: Get.height * 0.040),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Divider + or text
  Widget commonRow() {
    return Row(
      children: [
        Expanded(child: CustomLine(colors: [Colors.green,Colors.grey],)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AppText("OR",color: Colors.grey,),
        ),
        Expanded(child: CustomLine(colors: [Colors.green,Colors.grey],)),
      ],
    );
  }
}
