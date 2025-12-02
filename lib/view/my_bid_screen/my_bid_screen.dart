import 'dart:developer' as AppLogs;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import '../../utils/app_color.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common_font.dart';
import '../auction_order_details/auction_order_details.dart';

class MyBidScreen extends StatefulWidget {
  const MyBidScreen({super.key});

  @override
  State<MyBidScreen> createState() => _MyBidScreenState();
}

class _MyBidScreenState extends State<MyBidScreen> {

  /// ---- Dummy Bid List ----
  List<Map<String, dynamic>> myBidList = [
    {
      "name": "Stylish Sofa",
      "category": "Home & Living",
      "image":
      "https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp",
      "bidPrice": "3000",
      "orderNo": "#216514",
      "daysLeft": "3 Days Left",
      "colors": ["Red", "Blue", "Green"]
    },
    {
      "name": "Luxury Chair",
      "category": "Furniture",
      "image":
      "https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp",
      "bidPrice": "4500",
      "orderNo": "#845122",
      "daysLeft": "1 Day Left",
      "colors": ["Brown", "Cream", "Black"]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.auctionBid),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.030, vertical: Get.height * 0.020),
        child: Column(
          children: [
            Expanded(child: commonCartWidget())
          ],
        ),
      ),
    );
  }

  Widget commonCartWidget() {
    return myBidList.isNotEmpty ? Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppImage.svg(AppIcons.myBideImages),
        SizedBox(height: 20,),
        AppText("No Bids Found",color: Colors.grey,fontFamily: AppFont.semiBold),
      ],
    )) : ListView.builder(
      itemCount: myBidList.length,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.020),
      itemBuilder: (BuildContext context, int index) {
        final item = myBidList[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.010),
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
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AppImage.network(
                          width: Get.width * 0.20,
                          height: Get.height * 0.10,
                          item["image"],
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.035),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: AppText(
                                    item["name"],
                                    fontFamily: AppFont.bold,
                                    fontSize: Get.height * 0.016,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                AppText(
                                  item["orderNo"],
                                  fontSize: Get.height * 0.012,
                                  fontFamily: AppFont.semiBold,
                                ),
                              ],
                            ),

                            SizedBox(height: Get.height * 0.005),
                            AppText(
                              item["category"],
                              fontSize: Get.height * 0.012,
                              color: AppColor.textBlack,
                              fontFamily: AppFont.semiBold,
                            ),

                            SizedBox(height: Get.height * 0.005),
                            SizedBox(
                              height: Get.height * 0.022,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: item["colors"].map<Widget>((color) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: Get.width * 0.02),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.02),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: AppText(
                                          color,
                                          fontSize: Get.height * 0.009,
                                          fontFamily: AppFont.semiBold,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            SizedBox(height: Get.height * 0.008),

                            Row(
                              children: [
                                AppText(
                                  AppString.bidPrice,
                                  fontSize: Get.height * 0.014,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppText(
                                  " \$${item["bidPrice"]}",
                                  fontSize: Get.height * 0.014,
                                  color: AppColor.primary,
                                  fontFamily: AppFont.bold,
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColor.primary.withValues(alpha: 0.2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    child: Row(
                                      children: [
                                        Icon(Icons.alarm, size: 12),
                                        SizedBox(width: 4),
                                        AppText(
                                          item["daysLeft"],
                                          fontFamily: AppFont.semiBold,
                                          fontSize: Get.height * 0.010,
                                        ),
                                      ],
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

                // ---------- BORDER SECTION ----------
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

                // ---------- BUTTON SECTION ----------
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CommonButton(
                    title: AppString.viewAllBids,
                    onTap: () {
                      AppLogs.log("View Bids");
                      Get.to(() => AuctionOrderDetails(),
                          transition: Transition.rightToLeft);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
