import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as box;
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/become_seller/become_seller.dart';
import 'package:trendycart/view/change_password/change_password.dart';
import 'package:trendycart/view/edit_profile/edit_profile.dart';
import 'package:trendycart/view/forgot_password/forgot_password.dart';
import 'package:trendycart/view/my_address/my_address.dart';
import 'package:trendycart/view/my_bid_screen/my_bid_screen.dart';
import 'package:trendycart/view/my_order/my_order.dart';
import 'package:trendycart/view/setting/setting_screen.dart';

import '../../utils/common_font.dart';
import '../login_screen/model/login_model.dart';
import 'widget/profile_container_common.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginModel? userLogin;

  final box = GetStorage();

  late String userName = box.read('userName') ?? "Guest User";
  late String userEmail = box.read('userEmail') ?? "";
  late String userPhoto =
      box.read('userPhoto') ??
      "https://cdn-icons-png.flaticon.com/512/149/149071.png";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value:  SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
            Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: double.infinity,
                height: Get.height * 0.16,
                child: AppImage.svg(
                  AppIcons.backImages,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: Get.height * 0.10,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            AppLogs.log("Go to Edit Profile");
                            Get.to(() => const EditProfile(), transition: Transition.rightToLeft);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.white),
                            ),
                            child: CircleAvatar(
                              radius: Get.height * 0.050,
                              backgroundImage: NetworkImage(userPhoto),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: -5,
                          child: GestureDetector(
      
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primary,
                                border: Border.all(width: 1, color: Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: AppImage.svg(AppIcons.editProfile),
                              ),
                            ),
                          ),
                        ),
      
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
              SizedBox(height: Get.height * 0.060),
              AppText(
                userName,
                fontSize: Get.height * 0.020, fontFamily:AppFont.bold
              ),
              SizedBox(height: Get.height * 0.005),
              AppText(
                userEmail,
                fontSize: Get.height * 0.014,
                color: Colors.grey,
                  fontFamily: AppFont.medium
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.020),
                    AppText(AppString.personalInfo,fontSize: 16,fontFamily: AppFont.bold),
                    SizedBox(height: Get.height * 0.030),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonPersonalInfomation(images: AppIcons.myOrderIcon, title: AppString.myOrder, onTap: () { AppLogs.log("go to My Order");
                          Get.to(() => MyOrder(), transition: Transition.rightToLeft); }),
      
                          CommonPersonalInfomation(images: AppIcons.myAddressIcon, title: AppString.myAddress, onTap: () {  AppLogs.log("My Address");
                          Get.to(() => MyAddress(), transition: Transition.rightToLeft); }),
      
                          CommonPersonalInfomation(images: AppIcons.myBidIcon, title: AppString.myBid, onTap: () {  AppLogs.log("My  Bid");
                          Get.to(
                                () => MyBidScreen(),
                            transition: Transition.rightToLeft,
                          ); })
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.030),
                    AppText(AppString.sellerAccount,fontFamily: AppFont.bold,fontSize: 16,),
                    SizedBox(height: Get.height * 0.015),
                    ProfileContainerCommon(
                      images: AppIcons.seller,
                      title: AppString.becomeSeller,
                      onTap: () {
                        AppLogs.log("Become Seller");
                        Get.to(
                              () => BecomeSeller(),
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    SizedBox(height: Get.height * 0.020),
                    AppText(AppString.security, fontFamily: AppFont.bold,fontSize: 16,),
                    SizedBox(height: Get.height * 0.015),
                    ProfileContainerCommon(
                      images: AppIcons.changePassword,
                      title: AppString.changePassword,
                      onTap: () {
                        AppLogs.log("Change Password");
                        Get.to(
                              () => ChangePassword(),
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    SizedBox(height: Get.height * 0.015),
                    ProfileContainerCommon(
                      images: AppIcons.forgotPassword,
                      title: AppString.forgotPassword,
                      onTap: () {
                        AppLogs.log("Forgot Password");
                        Get.to(
                              () => ForgotPassword(),
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                    SizedBox(height: Get.height * 0.015),
                    ProfileContainerCommon(
                      images: AppIcons.setting,
                      title: AppString.setting,
                      onTap: () {
                        AppLogs.log("setting");
                        Get.to(
                              () => SettingScreen(),
                          transition: Transition.rightToLeft,
                        );
                      },
                    ),
                  ],
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }

  Widget CommonPersonalInfomation({required String images,required String title,required Function() onTap}){
    return   Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppImage.svg(images,height: 35),
              )),
        ),
        SizedBox(height: 15,),
        AppText(title,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: AppFont.semiBold)
      ],
    );
  }

}
