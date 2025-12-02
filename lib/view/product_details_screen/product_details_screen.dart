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

import '../../utils/common/common_line.dart';
import '../../utils/common/widgets.dart';
import '../../utils/common_font.dart';
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
      backgroundColor: AppColor.background,
      appBar: AppAppBar(
        title: AppString.productDetails,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AppImage.svg(AppIcons.share, height: 30, width: 30),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: Obx(() => OutlineWhiteButton(
                    text: productController.isLoading.value
                        ? "Adding..."
                        : "Add to cart",
                    onTap: productController.isLoading.value
                        ? null // disable
                        : () {
                      productController.addProduct(productId: data.id ?? "");
                    },
                    icon: productController.isLoading.value
                        ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : AppImage.svg(AppIcons.addToCart),
                  )),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: CommonBlackButton(
                    title: "By Now",
                    onTap: () {
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.020),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: AppImage.network(
                  data.mainImage ?? "",
                  width: double.infinity,
                  height: Get.height * 0.50,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.040,
                  vertical: Get.height * 0.020,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AppText(
                            data.productName,
                            color: AppColor.textBlack,
                            fontFamily: AppFont.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          // onTap: () => homeController.toggleFavorite(index),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    AppText(
                      '\$ ${data.price}',
                      color: AppColor.primary,
                      fontFamily: AppFont.bold,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppText(
                                  "4.5",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily:AppFont.bold,
                                ),
                                SizedBox(width: 5),
                                AppImage.svg(
                                  AppIcons.star,
                                  color: Colors.yellow,
                                  height: 20,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            AppText(
                              "Ratings",
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: AppFont.medium,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              "02",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: AppFont.bold,
                            ),
                            SizedBox(height: 5),
                            AppText("Sold", fontSize: 16, color: Colors.grey,fontFamily: AppFont.medium,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              "Berlin Germany",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: AppFont.bold,
                            ),
                            SizedBox(height: 5),
                            AppText(
                              "Location",
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: AppFont.medium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.015),
                    CustomLine(
                      width: double.infinity,
                      colors: [
                        Colors.grey.withValues(alpha: 0.2),
                        Colors.grey.withValues(alpha: 0.2),
                      ],
                      height: 2,
                    ),
                    SizedBox(height: Get.height * 0.030),
                    AppText(
                      'Meterial',
                      fontSize: Get.height * 0.018,
                      fontFamily: AppFont.medium,
                      color: AppColor.textBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Get.height * 0.015),
                    // ListView.builder(
                    //   scrollDirection: Axis.vertical,
                    //   itemCount: data.length,      // ✔ data must be List
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemBuilder: (BuildContext context, int index) {
                    //     final just = data[index];  // ✔ safe
                    //     return GestureDetector(
                    //       onTap: (){},
                    //       child: Container(
                    //         margin: EdgeInsets.only(top: Get.height * 0.020),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(15),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.black.withValues(alpha: 0.08),
                    //               blurRadius: 6,
                    //               offset: Offset(0, 3),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Padding(
                    //           padding: EdgeInsets.all(8.0),
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Expanded(
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //
                    //                   ],
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
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
                          color: Colors.grey,
                          fontFamily: AppFont.medium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: Get.width * 0.020),
                        AppText(
                          'Product Details ',
                          fontSize: Get.height * 0.014,
                          color: AppColor.textBlack,
                          fontFamily: AppFont.semiBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.015),
                    Row(
                      children: [
                        AppText(
                          'Category :',
                          fontSize: Get.height * 0.014,
                          color: Colors.grey,
                          fontFamily: AppFont.medium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: Get.width * 0.020),
                        AppText(
                          'Product Details ',
                          fontSize: Get.height * 0.014,
                          color: AppColor.primary,
                          fontFamily: AppFont.semiBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    if (data.description != null && data.description!.isNotEmpty) ...[
                      SizedBox(height: Get.height * 0.030),
                      AppText(
                        AppString.productDetails,
                        fontSize: Get.height * 0.018,
                        fontFamily: AppFont.semiBold,
                        color: AppColor.textBlack,
                      ),
                      SizedBox(height: Get.height * 0.015),
                      AppText(
                        data.description!,
                        color: AppColor.textBlack,
                        fontSize: Get.height * 0.012,
                      ),
                    ],
                    SizedBox(height: Get.height * 0.030),
                    AppText(
                      AppString.relatedProducts,
                      fontSize: Get.height * 0.018,
                      fontFamily: AppFont.bold,
                      color: AppColor.textBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Get.height * 0.015),
                    newCollectionList(onTap: (data) {}),
                    SizedBox(height: Get.height * 0.030),
                    AppText(
                      AppString.aboutThisSeller,
                      fontSize: Get.height * 0.018,
                      fontFamily: AppFont.bold,
                      color: AppColor.textBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Get.height * 0.015),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: AppImage.network(
                              "",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
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
                              fontFamily: AppFont.bold,
                              color: AppColor.textBlack,
                            ),
                            SizedBox(width: Get.width * 0.020),
                            AppText(
                              "Follower : ${productController.product.isEmpty ? 0 : (productController.product.first.followerCount ?? 0)}",
                              fontSize: Get.height * 0.012,
                              color: AppColor.textBlack,
                              fontFamily: AppFont.medium,
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.primary,
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
                              fontFamily: AppFont.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newCollectionList({required Function(dynamic data) onTap}) {
    return SizedBox(
      height: Get.height * 0.27,
      child: homeController.relatedProductList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImage.svg(AppIcons.noData),
                  SizedBox(height: 15),
                  AppText("No Data"),
                ],
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.relatedProductList.length,
              itemBuilder: (context, index) {
                final data = homeController.relatedProductList[index];
                final image = data.mainImage ?? "";
                final name = data.productName ?? "";
                final price = data.price ?? 0;
                final desc = data.description ?? "";
                final isFav = data.isFavorite;
                return GestureDetector(
                  onTap: () => onTap(data),
                  child: Container(
                    width: Get.width * 0.40,
                    margin: EdgeInsets.only(right: 14, bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: AppImage.network(
                                  image,
                                  width: double.infinity,
                                  height: Get.height * 0.15,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 15,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Row(
                                  children: [
                                    AppText("4.5", fontSize: 12,fontFamily: AppFont.bold,),
                                    SizedBox(width: 2),
                                    AppImage.svg(AppIcons.star, height: 18, color: Colors.yellow)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  name,
                                  fontSize: Get.height * 0.014,
                                  fontFamily: AppFont.bold,
                                  color: AppColor.textBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 8),
                                AppText(
                                  desc,
                                  fontSize: Get.height * 0.013,
                                  color: Colors.grey[700],
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: AppFont.medium,
                                ),
                                SizedBox(height: 8),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        "\$$price",
                                        fontSize: Get.height * 0.016,
                                        color: AppColor.price,
                                        fontFamily: AppFont.bold,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.primary,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          child: AppText(
                                            "Buy",
                                            fontSize: Get.height * 0.014,
                                            color: AppColor.textWhite,
                                            fontFamily:AppFont.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
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
