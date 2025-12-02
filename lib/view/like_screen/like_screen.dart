import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_loader.dart';
import '../../utils/common/common_appbar.dart';
import '../../utils/common_font.dart';
import '../bottom_bar/controller/bottom_controller.dart';
import '../product_details_screen/product_details_screen.dart';
import 'controller/like_controller.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  NavigationController navigationController = Get.find();
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    favoriteController.fetchFavoriteList();  // 🔥 Load favorites
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: "Wishlist"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                if (favoriteController.isLoading.value) {
                  return Center(child: AppLoaderWidget());
                }
                if (favoriteController.favoriteList.isEmpty) {
                  return Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImage.svg(AppIcons.likeIsemty),
                      SizedBox(height: 25,),
                      AppText("Wish list is empty!",color: Colors.grey,fontFamily: AppFont.semiBold,),
                    ],
                  ));
                }
                return Expanded(
                  child: GridView.builder(
                    itemCount: favoriteController.favoriteList.length,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 280,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (context, index) {
                      final item = favoriteController.favoriteList[index];
                      final product = item.product.first;
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: AppImage.network(
                                        product.mainImage,
                                        height: 150,
                                        width: double.infinity,
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
                                          AppText("4.5", fontSize: 12,fontFamily:AppFont.bold),
                                          SizedBox(width: 2),
                                          AppImage.svg(AppIcons.star, height: 18, color: Colors.yellow)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    right: 15,
                                    child: GestureDetector(
                                      onTap: () {
                                        favoriteController.toggleFavorite(
                                          item.productId,
                                          item.categoryId,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      product.productName,
                                      fontSize: 14,
                                      fontFamily:AppFont.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10),
                                    AppText(
                                      "\$ ${product.price}",
                                      fontSize: 15,
                                      color: AppColor.price,
                                        fontFamily: AppFont.bold,
                                    ),
                                    SizedBox(height: 6),
                                    SizedBox(
                                      height: 35,
                                      width: double.infinity,
                                      child: CommonButton(
                                        onTap: () {
                                          Get.to(()=>ProductDetailsScreen(productData: product,),
                                              transition: Transition.rightToLeft
                                          );
                                        },
                                        title: "Add to Cart",
                                      ),
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
