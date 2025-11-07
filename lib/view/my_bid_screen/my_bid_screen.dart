import 'dart:developer' as AppLogs;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../utils/app_color.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common/widgets.dart';
import '../auction_order_details/auction_order_details.dart';

class MyBidScreen extends StatefulWidget {
  const MyBidScreen({super.key});

  @override
  State<MyBidScreen> createState() => _MyBidScreenState();
}

class _MyBidScreenState extends State<MyBidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.auctionBid),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.030,vertical: Get.height * 0.020),
        child: Column(children: [
          commonCartWidget()
        ],),
      ),
    );
  }
  Widget commonCartWidget(){
    return  Expanded(
      child: ListView.builder(
        itemCount: 5,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.020),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:  EdgeInsets.symmetric(vertical:  Get.height * 0.010),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12, width: 1),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AppImage.network(
                            width: Get.width * 0.20,
                            height: Get.height * 0.10,
                            'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: Get.width * 0.035),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      "Hello Product Name",
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.height * 0.016,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  AppText(
                                    "#216514",
                                    fontSize: Get.height * 0.012,
                                    color: AppColor.textBlack,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.005),
                              AppText(
                                "Home & Living",
                                fontSize: Get.height * 0.012,
                                color: AppColor.textBlack,
                              ),
                              SizedBox(height: Get.height * 0.005),
                              SizedBox(
                                height: Get.height * 0.02,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        right: Get.width * 0.02,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.02,
                                          // vertical: Get.height * 0.01,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(color:  Colors.black ,),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(vertical: Get.height * 0.001),
                                          child: Center(
                                            child: AppText(
                                              "Red",
                                              fontSize: Get.height * 0.008,
                                              color:  AppColor.textBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: Get.height * 0.008),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        AppText(
                                          AppString.bidPrice,
                                          fontSize: Get.height * 0.014,
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColor.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        Expanded(
                                          child: AppText(
                                            ' \$3000',
                                            fontSize: Get.height * 0.014,
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColor.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 20,),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: AppColor.primary.withValues(alpha: 0.2)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.alarm,size: 12,),
                                            SizedBox(width: 2,),
                                            AppText(
                                              AppString.daysLeft,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: Get.height * 0.010,
                                              color: AppColor.textBlack,
                                            ),
                                          ],
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

                  ),
                  DottedBorder(
                    options: CustomPathDottedBorderOptions(
                      padding: EdgeInsets.all(8),
                      color: Colors.black,
                      strokeWidth: 1,
                      dashPattern: [10, 5],
                      customPath: (size) => Path()
                        ..moveTo(0, size.height)
                        ..relativeLineTo(size.width, 0),
                    ),
                    child: Container(),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommonButton(title: AppString.viewAllBids,onTap: (){
                      AppLogs.log("Go to Pay Now");
                      Get.to(()=>AuctionOrderDetails(),
                          transition: Transition.rightToLeft
                      );
                    },),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
