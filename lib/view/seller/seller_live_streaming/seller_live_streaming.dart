import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/common/app_image.dart';
import '../../../utils/common/app_text.dart';

class SellerLiveStreaming extends StatefulWidget {
  const SellerLiveStreaming({super.key});

  @override
  State<SellerLiveStreaming> createState() => _SellerLiveStreamingState();
}

class _SellerLiveStreamingState extends State<SellerLiveStreaming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.selectProduct),
      bottomSheet: Padding(
        padding:  EdgeInsets.all(15.0),
        child: CommonButton(title: AppString.goLive),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,),
          child: Column(
            children: [
              commonSelectProduct((){})
            ],
          ),
        ),
      ),
    );
  }

  Widget commonSelectProduct(Function() onTap){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 5,
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
                  offset:  Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:  BorderRadius.all(Radius.circular(15)
                        ),
                        child: AppImage.network(
                          width: Get.width * 0.25,
                          height: Get.height * 0.10,
                          'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: Get.width * 0.030,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText("Hello",fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),
                            SizedBox(height: Get.height * 0.008,),
                            AppText(
                              'Home Decor',
                              fontSize: Get.height * 0.012,
                              color: AppColor.textBlack,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: Get.height * 0.008,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AppText(
                                  'type:',
                                  fontSize: Get.height * 0.014,
                                  color: AppColor.textBlack,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: Get.width * 0.010,),
                                AppText(
                                  'No Reviews',
                                  fontSize: Get.height * 0.012,
                                  color: AppColor.textBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
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
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText("Total Amount"),
                      AppText("\$ 500",fontWeight: FontWeight.bold,fontSize: Get.height * 0.018,color: AppColor.primary,)
                    ],
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
