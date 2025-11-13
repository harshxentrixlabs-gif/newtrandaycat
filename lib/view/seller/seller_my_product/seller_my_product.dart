import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/common/app_image.dart';
import '../../../utils/common/app_text.dart';
import 'controller/seller_my_order_controller.dart';

class SellerMyProduct extends StatefulWidget {
  const SellerMyProduct({super.key});

  @override
  State<SellerMyProduct> createState() => _SellerMyOrderState();
}

class _SellerMyOrderState extends State<SellerMyProduct> {
  final SellerMyProductController sellerMyOrderController = Get.put(
    SellerMyProductController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.myOrder),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050,
            vertical: Get.height * 0.020,
          ),
          child: Column(
            children: [
              commonSellerMyOrder(),
              SizedBox(height: Get.height * 0.020),
              commonProduct(() {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonSellerMyOrder() {
    return SizedBox(
      height: Get.height * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemCount: sellerMyOrderController.oderList.length,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => Padding(
              padding: EdgeInsets.only(right: Get.width * 0.035),
              child: GestureDetector(
                onTap: () {
                  sellerMyOrderController.selectedIndex.value = index;
                  AppLogs.log(
                    "Selected index: ${sellerMyOrderController.selectedIndex.value}",
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04,
                    vertical: Get.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: sellerMyOrderController.selectedIndex.value == index
                        ? Colors.white
                        : AppColor.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      if (sellerMyOrderController.selectedIndex.value == index)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                    ],
                  ),
                  child: Center(
                    child: AppText(
                      sellerMyOrderController.oderList[index],
                      fontSize: Get.height * 0.014,
                      color:
                          sellerMyOrderController.selectedIndex.value == index
                          ? AppColor.textBlack
                          : AppColor.textWhite.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget commonProduct(Function() onTap) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(top: Get.height * 0.020),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: AppImage.network(
                      width: Get.width * 0.28,
                      height: Get.height * 0.12,
                      'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: Get.width * 0.030),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AppText(
                                "Hello",
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.cyan.withValues(alpha: 0.2)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(5.0),
                                child: AppText(
                                  "Approved",
                                  fontSize: Get.height * 0.012,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.005),
                        AppText(
                          "Hello",
                          fontSize: Get.height * 0.012,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Get.height * 0.008),
                        Row(
                          children: [
                            AppText(
                              'type :',
                              fontSize: Get.height * 0.012,
                              color: AppColor.textBlack,
                              overflow: TextOverflow.ellipsis,
                            ),
                            AppText(
                              'Clock',
                              fontSize: Get.height * 0.012,
                              color: AppColor.primary,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.008),
                        AppText(
                          '\$3000',
                          fontSize: Get.height * 0.014,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
