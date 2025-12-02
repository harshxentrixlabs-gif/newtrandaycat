import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_text.dart';

import '../../utils/app_color.dart';
import '../../utils/common/app_image.dart';

class AuctionOrderDetails extends StatefulWidget {
  const AuctionOrderDetails({super.key});

  @override
  State<AuctionOrderDetails> createState() => _AuctionOrderDetailsState();
}

class _AuctionOrderDetailsState extends State<AuctionOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value:  SystemUiOverlayStyle(
        statusBarColor: Color(0xffffdabe),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppAppBar(title: AppString.auctionOrderDetails),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.030,
            vertical: Get.height * 0.020,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                AppString.orderInfo,
                fontWeight: FontWeight.bold,
                fontSize: Get.height * 0.018,
              ),
              SizedBox(height: Get.height * 0.020),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AppImage.network(
                      width: Get.width * 0.12,
                      height: Get.height * 0.05,
                      'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: Get.width * 0.035),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          "Hello Product Name",
                          fontWeight: FontWeight.bold,
                          fontSize: Get.height * 0.016,
                          overflow: TextOverflow.ellipsis,
                        ),
                        AppText(
                          "\$200",
                          fontSize: Get.height * 0.016,
                          color: AppColor.textBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.030),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.030,
                    vertical: Get.height * 0.020,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 10),
                          AppText(
                            AppString.deliveryLocation,
                            fontWeight: FontWeight.bold,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){},
                              child: Icon(Icons.arrow_circle_right_outlined)),
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
                      SizedBox(height: Get.height * 0.015),
                      AppText(
                        AppString.pleaseSelectADeliveryAddress,
                        fontSize: Get.height * 0.014,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.030),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    AppString.subtotal,
                    fontSize: Get.height * 0.016,
                  ),
                  AppText(
                    "\$200",
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.016,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.010),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    AppString.deliveryCharge,
                    fontSize: Get.height * 0.016,
                  ),
                  AppText(
                    "\$200",
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.016,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.010),
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
              SizedBox(height: Get.height * 0.010),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    AppString.total,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.016,
                  ),
                  AppText(
                    "\$200",
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.016,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
