import 'dart:developer' as AppLogs;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';
import '../notification_screen/notification_screen.dart';
import '../profile_screen/widget/profile_container_common.dart';
import '../seller/seller_bank_account/seller_bank_account.dart';
import '../seller/seller_list_an_item/seller_an_item.dart';
import '../seller/seller_live_streaming/seller_live_streaming.dart';
import '../seller/seller_my_address/seller_my_address.dart';
import '../seller/seller_my_bid/seller_my_bid.dart';
import '../seller/seller_my_order/seller_my_order.dart';
import '../seller/seller_my_product/seller_my_product.dart';
import '../seller/seller_uploaded_short/seller_uploaded_short.dart';
import '../seller/seller_wallet/seller_wallet.dart';

class SellerAccount extends StatefulWidget {
  const SellerAccount({super.key});

  @override
  State<SellerAccount> createState() => _SellerAccountState();
}

class _SellerAccountState extends State<SellerAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(
        title: AppString.sellerAccount,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Get.to(
                  () => NotificationScreen(),
                  transition: Transition.rightToLeft,
                );
              },
              child: Container(
                height: Get.height * 0.040,
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AppImage.svg(AppIcons.notification),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050,
            vertical: Get.height * 0.020,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            backgroundImage: NetworkImage(
                              'https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170',
                            ),
                          ),
                          Positioned(
                            left: Get.width * 0.18,
                            right: Get.width * 0.000,
                            bottom: Get.height * 0.00,
                            top: Get.height * 0.06,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primary,
                                border: Border.all(width: 1, color: Colors.black),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  size: Get.height * 0.012,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height * 0.015),
                    AppText(
                      'Harsh Shiroya',
                      fontSize: Get.height * 0.020,
                      fontWeight: FontWeight.bold,
                    ),
                    AppText(
                      'Flutter Developer',
                      fontSize: Get.height * 0.014,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              DottedBorder(
                options: CustomPathDottedBorderOptions(
                  padding: EdgeInsets.all(8),
                  color: Colors.black.withValues(alpha: 0.2),
                  strokeWidth: 2,
                  dashPattern: [10, 5],
                  customPath: (size) => Path()
                    ..moveTo(0, size.height)
                    ..relativeLineTo(size.width, 0),
                ),
                child: Container(),
              ),
              SizedBox(height: Get.height * 0.020),
              AppText(AppString.personalInfo),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.menu,
                title: AppString.myProduct,
                onTap: () {
                  AppLogs.log("My Product");
                  Get.to(()=>SellerMyProduct(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.list,
                title: AppString.listAnItem,
                onTap: () {
                  AppLogs.log("List an item");
                  Get.to(()=>SellerAnItem(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.cart,
                title: AppString.myOrder,
                onTap: () {
                  AppLogs.log("My Order");
                  Get.to(()=>SellerMyOrder(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.wallet,
                title: AppString.myWallet,
                onTap: () {
                  AppLogs.log("My Wallet");
                  Get.to(()=>SellerWallet(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.live,
                title: AppString.liveStreaming,
                onTap: () {
                  AppLogs.log("Live Streaming");
                  Get.to(()=>SellerLiveStreaming(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.flash,
                title: AppString.uploadedShort,
                onTap: () {
                  AppLogs.log("Uploaded Short");
                  Get.to(()=>SellerUploadedShort(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.bidding,
                title: AppString.myBid,
                onTap: () {
                  AppLogs.log("My Bid");
                  Get.to(()=>SellerMyBid(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              AppText("General"),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.home,
                title: AppString.myAddress,
                onTap: () {
                  AppLogs.log("My Address");
                  Get.to(()=>SellerMyAddress(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
              SizedBox(height: Get.height * 0.020),
              ProfileContainerCommon(
                images: AppIcons.bank,
                title: AppString.bankAccount,
                onTap: () {
                  AppLogs.log("Bank Account");
                  Get.to(()=>SellerBankAccount(),
                      transition: Transition.rightToLeft
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
