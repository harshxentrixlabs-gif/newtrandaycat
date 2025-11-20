import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/home_screen/controller/home_controller.dart';
import 'package:trendycart/view/product_details_screen/controller/product_controller.dart';

import '../../utils/common/widgets.dart';
import 'model/product_details_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, this.productData});

  final dynamic productData;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductController productController = Get.put(ProductController());
  final HomeController homeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.productDetailsMethods();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.productData;
    return Scaffold(
      appBar: AppAppBar(
        title: AppString.productDetails,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary.withValues(alpha: 0.30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppImage.svg(AppIcons.share, height: 20, width: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.favorite)),
            Expanded(
              child: SizedBox(height: 45,child: OutlineWhiteButton(text: "By Now", onTap: () {})),
            ),
            SizedBox(width: 10,),
            Expanded(child: SizedBox(height: 45,child: CommonButton(title: "Add To Cart",onTap: (){productController.addProduct(productId: data.id ?? "");
            },),))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050,
            vertical: Get.height * 0.030,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: AppColor.primary.withValues(alpha: 0.1),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      child: AppImage.network(
                        data.mainImage ?? "",
                        width: double.infinity,
                        height: Get.height * 0.45,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.030,
                        vertical: Get.height * 0.020,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            data.productName,
                            color: AppColor.textBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 5),
                          AppText(
                            data.description ?? "",
                            color: AppColor.textBlack,
                            fontSize: Get.height * 0.012,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              AppImage.svg(AppIcons.map, color: Colors.grey),
                              SizedBox(width: 3),
                              AppText(
                                "Ordino,Andorra",
                                fontSize: Get.height * 0.011,
                              ),
                              SizedBox(width: 3),
                              AppImage.svg(
                                AppIcons.cart1,
                                color: Colors.grey,
                                height: 18,
                              ),
                              SizedBox(width: 3),
                              AppText(
                                AppString.oSoda,
                                fontSize: Get.height * 0.011,
                              ),
                              SizedBox(width: 3),
                              AppImage.svg(
                                AppIcons.star,
                                color: Colors.yellow,
                                height: 18,
                              ),
                              SizedBox(width: 3),
                              AppText(
                                AppString.noReviews,
                                fontSize: Get.height * 0.011,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          AppText(
                            '\$${data.price}',
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: AppColor.primary.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.alarm,
                                        size: 12,
                                        color: AppColor.primary,
                                      ),
                                      SizedBox(width: 2),
                                      AppText(
                                        AppString.daysLeft,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: Get.height * 0.010,
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: AppText(
                                      AppString.viewAllBids,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: Get.height * 0.010,
                                      color: AppColor.textBlack,
                                      fontWeight: FontWeight.bold,
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
              SizedBox(height: Get.height * 0.030),
              AppText(
                'Type',
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
                color: AppColor.textBlack,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Get.height * 0.015),
              SizedBox(height: Get.height * 0.030),
              AppText(
                AppString.productDetails,
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
                color: AppColor.textBlack,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Get.height * 0.015),
              Row(
                children: [
                  AppText(
                    AppString.product,
                    fontSize: Get.height * 0.014,
                    color: AppColor.textBlack,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: Get.width * 0.020),
                  AppText(
                    'Product Details ',
                    fontSize: Get.height * 0.014,
                    color: AppColor.textBlack,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.015),
              Row(
                children: [
                  AppText(
                    'Product Details  :',
                    fontSize: Get.height * 0.014,
                    color: AppColor.textBlack,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: Get.width * 0.020),
                  AppText(
                    'Product Details ',
                    fontSize: Get.height * 0.014,
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.015),
              AppText(
                data.description,
                color: AppColor.textBlack,
                fontSize: Get.height * 0.012,
              ),
              SizedBox(height: Get.height * 0.030),
              AppText(
                AppString.relatedProducts,
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
                color: AppColor.textBlack,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Get.height * 0.015),
              commonLiveAuction(() {
                AppLogs.log("Live Auction");
              }),
              SizedBox(height: Get.height * 0.030),
              AppText(
                AppString.aboutThisSeller,
                fontSize: Get.height * 0.018,
                fontWeight: FontWeight.w600,
                color: AppColor.textBlack,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Get.height * 0.015),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        width: Get.width * 0.09,
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.020),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Harsh",
                        fontSize: Get.height * 0.015,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textBlack,
                      ),
                      SizedBox(width: Get.width * 0.020),
                      AppText(
                        "Follower : ${productController.product.isEmpty ? 0 : (productController.product.first.followerCount ?? 0)}",
                        fontSize: Get.height * 0.012,
                        color: AppColor.textBlack,
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 14.0,
                        right: 14,
                        top: 8,
                        bottom: 8,
                      ),
                      child: AppText(
                        AppString.follow,
                        color: Colors.white,
                        fontSize: Get.height * 0.012,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonLiveAuction(Function() onTap) {
    return SizedBox(
      height: Get.height * 0.24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.data.length,
        padding: EdgeInsets.only(right: 10),
        itemBuilder: (BuildContext context, int index) {
          final data = homeController.data[index];
          AppLogs.log("data NewCollection $data");
          return GestureDetector(
            onTap: () => onTap,
            child: Container(
              width: Get.width * 0.38,
              margin: EdgeInsets.only(right: 14, bottom: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppText(
                              data.productName.toString(),
                              fontSize: Get.height * 0.014,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textBlack,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: Get.height * 0.005),
                          Expanded(
                            child: Row(
                              children: [
                                AppText(
                                  '\$${data.price ?? 0}',
                                  fontSize: Get.height * 0.016,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 10),
                                AppImage.svg(
                                  AppIcons.star,
                                  height: Get.height * 0.020,
                                  color: Colors.yellow,
                                ),

                                Flexible(
                                  child: AppText(
                                    data.rating == null
                                        ? 'No rating'
                                        : '${data.rating} No Reviews',
                                    fontSize: Get.height * 0.013,
                                    color: AppColor.textBlack,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.005),
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

  // Widget commonNewCategoriesListName() {
  //   return SizedBox(
  //     height: Get.height * 0.05,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 5,
  //       itemBuilder: (BuildContext context, int index) {
  //         return Obx(
  //           () => Padding(
  //             padding: EdgeInsets.only(right: Get.width * 0.035,bottom: 5,top: 5),
  //             child: GestureDetector(
  //               onTap: () {
  //                 productController.selectedIndex.value = index;
  //                 AppLogs.log(
  //                   "Selected index: ${productController.selectedIndex.value}",
  //                 );
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: Get.width * 0.04,
  //                   vertical: Get.height * 0.01,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: productController.selectedIndex.value == index
  //                       ? Colors.white
  //                       : AppColor.primary,
  //                   borderRadius: BorderRadius.circular(10),
  //                   boxShadow: [
  //                     if (productController.selectedIndex.value == index)
  //                       BoxShadow(
  //                         color: Colors.black.withOpacity(0.15),
  //                         blurRadius: 8,
  //                         offset: Offset(0, 3),
  //                       ),
  //                   ],
  //                 ),
  //                 child: Center(
  //                   child: AppText(
  //                     "Hello",
  //                     fontSize: Get.height * 0.014,
  //                     color: productController.selectedIndex.value == index
  //                         ? AppColor.textBlack
  //                         : AppColor.textWhite.withOpacity(0.9),
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
