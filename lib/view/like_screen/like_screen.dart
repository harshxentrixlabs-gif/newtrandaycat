import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import '../../utils/app_color.dart';
import '../../utils/common/common_appbar.dart';
import '../navigation_menu/controller/navigation_controller.dart';
import 'model/controller/like_controller.dart';

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
    // TODO: implement initState
    super.initState();
    favoriteController.fetchFavoriteProducts();
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
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Wishlist Collection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // 🔥 GRID VIEW
            Expanded(
              child: Obx(() {
                if (favoriteController.favoriteProducts.isEmpty) {
                  return const Center(child: Text("No Favorites Found"));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: favoriteController.favoriteProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.90,
                  ),
                  itemBuilder: (context, index) {
                    final item = favoriteController.favoriteProducts[index];
                    final product = item.product[0];

                    return Stack(
                      children: [
                        // PRODUCT CARD
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: AppImage.network(
                                  product.mainImage ?? "",
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      product.productName ?? "",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                    ),
                                     SizedBox(height: 4),
                                    AppText(
                                      product.category ?? "",
                                        fontSize: 12,
                                        color: Colors.grey,
                                    ),
                                     SizedBox(height: 6),
                                    AppText(
                                      "\$${product.price}",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ❤️ LIKE/UNLIKE BUTTON
                        // ❤️ LIKE/UNLIKE BUTTON
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Obx(() {
                            final isFav = favoriteController.isFavorite(item.productId!);

                            return InkWell(
                              onTap: () {
                                favoriteController.toggleFavorite(item.productId!);
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: isFav ? Colors.red : Colors.grey,
                                  size: 28,
                                ),
                              ),
                            );
                          }),
                        ),


                      ],
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
