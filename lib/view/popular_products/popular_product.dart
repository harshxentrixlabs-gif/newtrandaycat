import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/view/home_screen/controller/home_controller.dart';

import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';

class PopularProduct extends StatefulWidget {
  const PopularProduct({super.key});

  @override
  State<PopularProduct> createState() => _PopularProductState();
}




class _PopularProductState extends State<PopularProduct> {

  final HomeController homeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.popularProducts),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.010),
        child: Column(
          children: [
            Obx(()=>commonPopularProduct((){})),
          ],
        ),
      ),
    );
  }

  Widget commonPopularProduct(Function() onTap) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 0.80,
        ),
        itemCount:homeController.data.length,
        itemBuilder: (BuildContext context, int index) {
          final data = homeController.data[index];
          return  GestureDetector(
            onTap: onTap,
            child: Container(
              width: Get.width * 0.38,
              margin:  EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset:  Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      ClipRRect(
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: AppImage.network(
                         data.mainImage.toString(),
                          width: double.infinity,
                          height: Get.height * 0.14,
                          fit: BoxFit.cover,
                        ),
                      ),
                  Expanded(
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            data.productName.toString(),
                            fontSize: Get.height * 0.014,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textBlack,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                AppText(
                                  '\$${data.price}',
                                  fontSize: Get.height * 0.016,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                AppImage.svg(
                                  AppIcons.star,
                                  height: Get.height * 0.020,
                                  color: Colors.yellow,
                                ),
                                AppText(
                                  data.rating == null ? "0" : "No Review",
                                  fontSize: Get.height * 0.013,
                                  color: AppColor.textBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              data.description.toString(),
                              fontSize: Get.height * 0.013,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
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
