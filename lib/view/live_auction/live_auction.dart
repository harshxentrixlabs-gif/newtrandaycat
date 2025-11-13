import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../utils/app_color.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';

class LiveAuction extends StatefulWidget {
  const LiveAuction({super.key});

  @override
  State<LiveAuction> createState() => _LiveAuctionState();
}

class _LiveAuctionState extends State<LiveAuction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.liveAuction),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.020),
          child: Column(
            children: [
              commonLiveAuction((){}),
            ],
          ),
        ),
      ),
    );
  }
  Widget commonLiveAuction(Function() onTap) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 0.75,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount:12,
      itemBuilder: (BuildContext context, int index) {
        return  GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: AppImage.network(
                    width: double.infinity,
                    height: Get.height * 0.16,
                    'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    AppText(
                      'Live Selling',
                      fontSize: Get.height * 0.016,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBlack,
                    ),
                    SizedBox(height: 5),
                    AppText(
                      'Limited Time Offer!',
                      fontSize: Get.height * 0.012,
                      color: AppColor.textBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: AppText(
                      AppString.daysLeft,
                      fontSize: Get.height * 0.014,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
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
