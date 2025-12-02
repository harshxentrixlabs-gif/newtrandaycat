import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/view/help_supports/help_support.dart';
import 'package:trendycart/view/login_screen/controller/login_controller.dart';
import 'package:trendycart/view/login_screen/login_screen.dart';
import 'package:trendycart/view/secutity_screen/security_screen.dart';

import '../../app_string/app_string.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common/widgets.dart';
import '../../utils/common_font.dart';
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
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
          child: Row(
            children: [
              Expanded(child: OutlineWhiteButton(text: 'Delete Account', onTap: () {  },),),
              SizedBox(width: 10,),
              Expanded(
                child: CommonBlackButton(title: "Log Out",  onTap: (){
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
                                AppImage.svg(AppIcons.logout),
                                SizedBox(height: 10),
                                AppText(
                                 "Oh no! You're Leaving...",
                                  color: AppColor.textBlack,
                                  fontSize: 20,
                                    fontFamily: AppFont.bold,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10),
                                AppText(
                                  "Are you sure?",
                                  color: Colors.grey,
                                  fontSize: 16,
                                  textAlign: TextAlign.center,
                                  fontFamily:  AppFont.medium,
                                ),
                                SizedBox(height: 10),
                                CommonBlackButton(
                                  onTap: () {
                                    Get.back();
                                  },
                                  title: "No, Just Kidding",
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
                                    "Yes, Log Me out",
                                    fontSize: Get.height * 0.020,
                                    fontFamily: AppFont.bold,
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
                },),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.030,
          vertical: Get.height * 0.020,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("General",fontFamily: AppFont.bold),
            const SizedBox(height: 20),
            SettingSection(
              children: [
                SettingTile(
                  title: "Language",
                  onTap: () {
                    AppLogs.log("Language");
                  },
                  showDivider: false,
                ),
              ],
            ),
             SizedBox(height: 20),
            AppText("Account",fontFamily: AppFont.bold),
             SizedBox(height: 20),
            SettingSection(
              children: [
                SettingTile(
                  title: AppString.security,
                  onTap: () => Get.to(() => SecurityScreen(),
                      transition: Transition.rightToLeft),
                ),
                SettingTile(
                  title: AppString.legalAndPolicies,
                  onTap: () => Get.to(() => SecurityScreen(),
                      transition: Transition.rightToLeft),
                ),
                SettingTile(
                  title: AppString.helpAndSupport,
                  onTap: () => Get.to(() => HelpSupport(),
                      transition: Transition.rightToLeft),
                  showDivider: false,
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

class SettingTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  const SettingTile({
    Key? key,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(title,fontFamily: AppFont.semiBold),
              const Icon(Icons.arrow_forward_ios_outlined,
                  color: Colors.black, size: 20),
            ],
          ),
        ),
        if (showDivider) ...[
           SizedBox(height: 10),
           Divider(color: Colors.black),
           SizedBox(height: 15),
        ],
      ],
    );
  }
}

class SettingSection extends StatelessWidget {
  final List<Widget> children;

  const SettingSection({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: children),
      ),
    );
  }
}


