import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_print.dart';
import '../../app_string/app_string.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_appbar.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common/common_line.dart';
import '../../utils/common/widgets.dart';
import '../../utils/common_font.dart';
import '../home_screen/controller/home_controller.dart';
import 'controller/product_controller.dart';
import 'model/product_details_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductController productController = Get.put(ProductController());
  final HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();

    productController.productDetailsMethods(productId: widget.productId).then((_) {
      if (productController.productDetails.isNotEmpty) {
        final product = productController.productDetails[0];
        productController.relatedProductsMethod(
          productId: product.id,
          categoryId: product.category.id.toString(),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(
        title: AppString.productDetails,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: AppImage.svg(AppIcons.share, height: 28, width: 28),
          ),
        ],
      ),
      bottomSheet: Obx(
        () => Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlineWhiteButton(
                    text: productController.isLoading.value
                        ? "Adding..."
                        : "Add to Cart",
                    icon: productController.isLoading.value
                        ? SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : AppImage.svg(AppIcons.addToCart),
                    onTap: productController.isLoading.value
                        ? () {}
                        : () => productController.addProduct(
                            productId: widget.productId,
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonBlackButton(title: "Buy Now", onTap: () {}),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: productController.productDetails.length,
          itemBuilder: (context, index) {
            final data = productController.productDetails[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImage.network(
                  data.mainImage,
                  width: double.infinity,
                  height: Get.height * 0.45,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,
                    vertical: Get.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(
                              data.productName ?? "-",
                              fontSize: Get.height * 0.02,
                              fontFamily: AppFont.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => productController.toggleFavoriteProduct(data.id),
                            child: Obx(() => Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                shape: BoxShape.circle,
                              ),
                              child: productController.isLoading.value
                                  ? SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                                  : Icon(
                                data.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: data.isFavorite ? Colors.red : Colors.black54,
                              ),
                            )),
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.015),
                      AppText(
                        "\$ ${data.price ?? "0"}",
                        fontSize: Get.height * 0.02,
                        fontFamily: AppFont.semiBold,
                        color: AppColor.primary,
                      ),
                      SizedBox(height: Get.height * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                "${data.review}",
                                fontSize: 16,
                                fontFamily: AppFont.bold,
                              ),
                               SizedBox(height: 5),
                              AppText(
                                "Ratings",
                                fontFamily: AppFont.medium,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                "${data.sold}",
                                fontSize: 16,
                                fontFamily: AppFont.bold,
                              ),
                              SizedBox(height: Get.height * 0.015),
                              AppText(
                                "Sold",
                                fontFamily: AppFont.medium,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                "Berlin Germany",
                                fontSize: 16,
                                fontFamily: AppFont.bold,
                              ),
                               SizedBox(height: 5),
                              AppText(
                                "Location",
                                fontFamily: AppFont.medium,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: Get.height * 0.015),
                      CustomLine(colors: [Colors.grey, Colors.grey]),
                      SizedBox(height: Get.height * 0.015),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.attributes.length,
                        itemBuilder: (context, attrIndex) {
                          final attr = data.attributes[attrIndex];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  attr.name,
                                  fontFamily: AppFont.bold,
                                  fontSize: 16,
                                ),
                                const SizedBox(height: 8),

                                /// Values Horizontal Scroll
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                      attr.values.length,
                                          (i) => Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                        ),
                                        child: AppText(
                                          attr.values[i].toString(),
                                          fontFamily: AppFont.medium,
                                          fontSize: Get.height * 0.014,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: Get.height * 0.015),
                      AppText(
                        "Product Details",
                        fontFamily: AppFont.bold,
                        fontSize: 18,
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
                            'Category  :',
                            fontSize: Get.height * 0.014,
                            color: Colors.grey,
                            fontFamily: AppFont.medium,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: Get.width * 0.020),
                          Flexible(
                            child: AppText(
                              data.category.name,
                              fontSize: Get.height * 0.014,
                              color: AppColor.primary,
                              fontFamily: AppFont.semiBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.015),
                      AppText(
                        data.description.toString(),
                        color: Colors.grey,
                        fontFamily: AppFont.medium,
                      ),
                      if (productController.relatedProductList.isNotEmpty) ...[
                        SizedBox(height: Get.height * 0.015),
                        AppText(
                          "Related Product",
                          fontFamily: AppFont.bold,
                          fontSize: 18,
                        ),
                        SizedBox(height: Get.height * 0.015),
                        newCollectionList(onTap: (data) {
                        }),
                      ],
                      SizedBox(height: Get.height * 0.015),
                      AppText(
                        "About this Seller",
                        fontFamily: AppFont.bold,
                        fontSize: 18,
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
                                "Follower : ${data.followerCount}",
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
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }




  Widget newCollectionList({required Function(dynamic data) onTap}) {
    return Obx(() {
      if (productController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: Get.height * 0.26,
        child: productController.relatedProductList.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage.svg(AppIcons.noData),
              SizedBox(height: 15),
              AppText(
                "No Data",
                fontFamily: AppFont.semiBold,
                color: Colors.grey,
              ),
            ],
          ),
        )
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productController.relatedProductList.length,
          itemBuilder: (context, index) {
            final data = productController.relatedProductList[index];
            final image = data.mainImage ?? "";
            final name = data.productName ?? "";
            final price = data.price ?? 0;

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AppImage.network(
                        image,
                        width: double.infinity,
                        height: Get.height * 0.15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            name,
                            fontSize: Get.height * 0.014,
                            fontFamily: AppFont.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10),
                          AppText(data.description.toString(),overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                "\$ $price",
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
                                    fontFamily: AppFont.bold,
                                    overflow: TextOverflow.ellipsis,
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
            );
          },
        ),
      );
    });
  }

}
