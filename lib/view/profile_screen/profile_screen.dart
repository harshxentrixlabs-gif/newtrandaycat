import 'package:flutter/material.dart';
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
import 'package:trendycart/view/forgot_password/forgot_password.dart';
import 'package:trendycart/view/my_address/my_address.dart';
import 'package:trendycart/view/my_bid_screen/my_bid_screen.dart';
import 'package:trendycart/view/my_order/my_order.dart';
import 'package:trendycart/view/setting/setting_screen.dart';

import '../login_screen/model/login_model.dart';
import '../seller_account_screen/seller_account.dart';
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
  late String userPhoto = box.read('userPhoto') ??
      "https://cdn-icons-png.flaticon.com/512/149/149071.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.040,vertical: Get.height * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 InkWell(
                   onTap: (){
                     AppLogs.log("go to setting");
                     Get.to(()=>SettingScreen(),
                     transition:Transition.rightToLeft
                     );
                   },
                   child: Container(
                     decoration: BoxDecoration(
                       color: AppColor.primary.withValues(alpha: 0.30),
                       shape: BoxShape.circle
                     ),
                       child: AppImage.svg(AppIcons.setting,height: Get.height * 0.035)),
                 )
                ],
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(userPhoto),
                          ),
                          Positioned(
                              left: Get.width * 0.18,
                              right: Get.width *  0.000,
                              bottom: Get.height * 0.00,
                              top: Get.height * 0.06,
                              child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.primary,
                                    border: Border.all(width: 1, color: Colors.black),
                                  ),
                                  child: Center(child: Icon(Icons.edit,size: Get.height * 0.012,color: Colors.white,)))),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    AppText(
                      userName,
                      fontSize:  Get.height * 0.020, fontWeight: FontWeight.bold,
                    ),
                    AppText(
                      userEmail,
                      fontSize: Get.height * 0.014, color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.015),
              AppText(AppString.personalInfo),
              SizedBox(height: Get.height * 0.015),
              ProfileContainerCommon(images: AppIcons.cart, title: AppString.myOrder, onTap: () {
                AppLogs.log("go to My Order");
                Get.to(()=>MyOrder(),
                  transition: Transition.rightToLeft
                );
              },),
              SizedBox(height: Get.height * 0.015),
              ProfileContainerCommon(images: AppIcons.homeAddress, title: AppString.myAddress, onTap: () {
                AppLogs.log("My Address");
                Get.to(()=>MyAddress(),
                    transition: Transition.rightToLeft
                );
              },),
              SizedBox(height: Get.height * 0.015),
              ProfileContainerCommon(images: AppIcons.bidding, title: AppString.myBid, onTap: () {
                AppLogs.log("My  Bid");
                Get.to(()=>MyBidScreen(),
                    transition: Transition.rightToLeft
                );
              },),
              SizedBox(height: Get.height * 0.020),
              AppText(AppString.sellerAccount),
              SizedBox(height: Get.height * 0.015),
              ProfileContainerCommon(images: AppIcons.seller, title: AppString.becomeSeller, onTap: () {
                AppLogs.log("Become Seller");
                Get.to(()=>BecomeSeller(),
                    transition: Transition.rightToLeft
                );
              },),
              SizedBox(height: 10,),
              // if(userLogin?.user?.isSeller == true)
              ProfileContainerCommon(images: AppIcons.seller, title: "Zen cart", onTap: () {
                AppLogs.log("Become Seller");
                Get.to(()=>SellerAccount(),
                    transition: Transition.rightToLeft
                );
              },),
              SizedBox(height: Get.height * 0.020),
              AppText(AppString.security),
              SizedBox(height: Get.height * 0.015),
              ProfileContainerCommon(images: AppIcons.changePassword, title: AppString.changePassword, onTap: () {
                AppLogs.log("Change Password");
                Get.to(()=>ChangePassword(),
                    transition: Transition.rightToLeft
                );
              },),
              SizedBox(height: Get.height * 0.015),
              ProfileContainerCommon(images: AppIcons.forgotPassword, title: AppString.forgotPassword, onTap: () {
                AppLogs.log("Forgot Password");
                Get.to(()=>ForgotPassword(),
                    transition: Transition.rightToLeft
                );
              },),
            ],
          ),
        ),
      ),
    );
  }
}
