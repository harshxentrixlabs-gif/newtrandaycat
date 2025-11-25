import 'dart:developer' as AppLogs;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/view/new_categories/controller/new_categories_controller.dart';

import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';
import '../home_screen/controller/home_controller.dart';

class NewCategories extends StatefulWidget {
  const NewCategories({super.key});

  @override
  State<NewCategories> createState() => _NewCategoriesState();
}

class _NewCategoriesState extends State<NewCategories> {

  final NewCategoriesController newCategoriesController = Get.put(NewCategoriesController());


  final HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();
    homeController.loadDefaultCategoryProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.newCategories),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.010),
        child: Column(
          children: [
            Obx(()=>commonNewCategoriesListName((catId) {
              // homeController.getRelatedProductsByCategory(catId);
            })),
            SizedBox(height: Get.height * 0.020,),
           Obx(()=> newCollectionGrid(onTap: (data) {  })),
          ],
        ),
      ),
    );
  }

  Widget commonNewCategoriesListName(Function(String catId) onTap) {
    return SizedBox(
      height: Get.height * 0.065,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.categoryList.length,
        padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
        itemBuilder: (context, index) {
          final category = homeController.categoryList[index];
          return Obx(
                () => Padding(
              padding: EdgeInsets.only(right: Get.width * 0.035),
              child: GestureDetector(
                onTap: () {
                  homeController.selectedIndex.value = index;
                  homeController.relatedProduct(
                    categoryId: category.id,
                    productId:
                    homeController.justForYouProduct[index].id ?? "",
                  );
                  onTap(category.id);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.03,
                    vertical: Get.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    gradient: homeController.selectedIndex.value == index
                        ? AppColor.primaryGradient
                        : const LinearGradient(
                      colors: [Colors.white, Colors.white],
                    ),
                    boxShadow: homeController.selectedIndex.value == index
                        ? []
                        : [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        AppImage.svg( index == 0
                            ? AppIcons.fashion
                            : index == 1
                            ? AppIcons.homeLiving
                            : index == 2
                            ? AppIcons.electronic
                            : index == 3
                            ? AppIcons.footwear
                            : '',
                        ),
                        SizedBox(width: 10,),
                        AppText(
                          category.name,
                          fontSize: Get.height * 0.014,
                          color: homeController.selectedIndex.value == index
                              ? Colors.white
                              : AppColor.textBlack ,
                          fontWeight:
                          homeController.selectedIndex.value == index
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget newCollectionGrid({
    required Function(dynamic data) onTap,
  }) {
    return homeController.relatedProductList.isEmpty
        ? Expanded(
          child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          AppImage.svg(AppIcons.noData),
          SizedBox(height: 15,),
          AppText("No Data"),
                ],
              )),
        )
        : Expanded(
          child: GridView.builder(
                padding: const EdgeInsets.only(top: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 16,
          childAspectRatio: 0.72, // perfect card ratio
                ),
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: AppImage.network(
                            image,
                            width: double.infinity,
                            height: Get.height * 0.16,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: GestureDetector(
                          onTap: () => homeController.toggleFavorite(index),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              color: Colors.white70,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.black54,
                            ),
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
                              AppText("4.5", fontSize: 12),
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
                      padding:  EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            name,
                            fontSize: Get.height * 0.014,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textBlack,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          AppText(
                            desc,
                            fontSize: Get.height * 0.013,
                            color: Colors.grey[700],
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppText(
                                  "₹$price",
                                  fontSize: Get.height * 0.016,
                                  color: AppColor.price,
                                  fontWeight: FontWeight.bold,
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
                                      fontWeight: FontWeight.bold,
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
