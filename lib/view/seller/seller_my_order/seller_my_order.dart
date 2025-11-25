import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_text.dart';

class SellerMyOrder extends StatefulWidget {
  const SellerMyOrder({super.key});

  @override
  State<SellerMyOrder> createState() => _SellerMyOrderState();
}

class _SellerMyOrderState extends State<SellerMyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.myOrder),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.050,
          vertical: Get.height * 0.020,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  AppString.selectDate,
                  fontSize: Get.height * 0.020,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: AppColor.primary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        AppText(
                          AppString.selectDateRange,
                          fontSize: Get.height * 0.014,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textWhite,
                        ),
                        SizedBox(width: 3),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.050,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColor.primary.withValues(alpha: 0.2)
              ),
              child: Padding(
                padding:  EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(AppString.orderList,fontWeight: FontWeight.w700,color: AppColor.primary,),
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
                    SizedBox(height: Get.height * 0.020,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(AppString.pendingOrder),
                        Row(
                          children: [
                            AppText("0"),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_ios_sharp,size: 18,)
                          ],
                        ),
                      ],
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
                    SizedBox(height: Get.height * 0.020,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(AppString.confirmedOrder),
                        Row(
                          children: [
                            AppText("0"),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_ios_sharp,size: 18,)
                          ],
                        ),
                      ],
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
                    SizedBox(height: Get.height * 0.020,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(AppString.outOfDeliveryOrder),
                        Row(
                          children: [
                            AppText("0"),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_ios_sharp,size: 18,)
                          ],
                        ),
                      ],
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
                    SizedBox(height: Get.height * 0.020,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(AppString.deliveredOrder),
                        Row(
                          children: [
                            AppText("0"),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_ios_sharp,size: 18,)
                          ],
                        ),
                      ],
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
                    SizedBox(height: Get.height * 0.020,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(AppString.cancelOrder),
                        Row(
                          children: [
                            AppText("0"),
                            SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_ios_sharp,size: 18,)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.050,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColor.primary.withValues(alpha: 0.2)
              ),
              child:Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(AppString.totalOrder),
                    Row(
                      children: [
                        AppText("0"),
                        SizedBox(width: 5,),
                        Icon(Icons.arrow_forward_ios_sharp,size: 18,)
                      ],
                    ),
                  ],
                ),
              ) ,
            )

          ],
        ),
      ),
    );
  }
}
