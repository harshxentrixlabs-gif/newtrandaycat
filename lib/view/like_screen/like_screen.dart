import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import '../../utils/app_color.dart';
import '../../utils/common/common_appbar.dart';
import '../navigation_menu/controller/navigation_controller.dart';
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
      appBar: CommonAppBar(
        name: box.read('userName') ?? "Guest User",
        subName: box.read('userEmail') ?? "",
        images: box.read('userPhoto') ??
            "https://cdn-icons-png.flaticon.com/512/149/149071.png",
        onTap: () => navigationController.changeIndex(4),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText("Wishlist Collection",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (favoriteController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (favoriteController.favoriteList.isEmpty) {
                  return Center(
                    child: AppText(
                      "Your wishlist is empty!",
                      fontSize: 16,
                    ),
                  );
                }
                return GridView.builder(
                  itemCount: favoriteController.favoriteList.length,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 260,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    final item = favoriteController.favoriteList[index];
                    final product = item.product.first;
                    return Container(
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
                              // IMAGE
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(14),
                                ),
                                child: AppImage.network(
                                  product.mainImage,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
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
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 6),
                                AppText(
                                  "₹${product.price}",
                                  fontSize: 15,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
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
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
