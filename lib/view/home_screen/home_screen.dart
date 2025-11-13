import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/common_appbar.dart';
import 'package:trendycart/view/home_screen/controller/home_controller.dart';
import 'package:trendycart/view/home_screen/model/home_model.dart';
import 'package:trendycart/view/live_auction/live_auction.dart';
import 'package:trendycart/view/live_screen/live_screen.dart';
import 'package:trendycart/view/new_categories/new_categories.dart';
import 'package:trendycart/view/notification_screen/notification_screen.dart';
import 'package:trendycart/view/popular_products/popular_product.dart';
import 'package:trendycart/view/product_details_screen/product_details_screen.dart';
import 'package:trendycart/view/search_screen/search_screen.dart';
import 'package:trendycart/view/shorts_screen/shorts_screen.dart';

import '../navigation_menu/controller/navigation_controller.dart';
import '../splash_screen/controller/splash_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  bool select = false;

  final box = GetStorage();

  late String userName = box.read('userName') ?? "Guest User";
  late String userEmail = box.read('userEmail') ?? "";
  late String userPhoto = box.read('userPhoto') ??
      "https://cdn-icons-png.flaticon.com/512/149/149071.png";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.liveSellerList;
    homeController.fetchLiveSellerList();
    homeController.fetchReels();
    homeController.fetchJustForYou();
    homeController.fetchProduct();
    AppLogs.log("Home Screen");
  }
  NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CommonAppBar(
        name: userName,
        subName: userEmail,
        images: userPhoto,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Get.width * 0.05),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(()=>SearchScreen(),);
                  },
                  child: Container(
                    height: Get.height * 0.040,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppImage.svg(AppIcons.search),
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.040),
                InkWell(
                  onTap: () {
                    Get.to(()=>NotificationScreen(),
                      transition: Transition.rightToLeft
                    );
                  },
                  child: Container(
                    height: Get.height * 0.040,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppImage.svg(AppIcons.notification),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ], onTap: () {
          navigationController.changeIndex(4);
      },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.025,
            vertical: Get.height * 0.020,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppImage.svg(AppIcons.star),
                  SizedBox(width: Get.width * 0.025),
                  AppText(AppString.liveSelling, fontWeight: FontWeight.w600),
                ],
              ),

              SizedBox(height: Get.height * 0.015),
             Obx(()=> commonLiveSelling((){
                Get.to(()=>LiveScreen());
              }),
             ),
              SizedBox(height: Get.height * 0.015),
              if(homeController.reelsResponse.isNotEmpty)
              commonViewAllAndTitle(title: AppString.shorts, images: AppIcons.flash, onTap: () {AppLogs.log("Shorts"); navigationController.changeIndex(1); }),
              if(homeController.reelsResponse.isNotEmpty)
              SizedBox(height: Get.height * 0.015),
              if(homeController.reelsResponse.isNotEmpty)
              commonShorts((){
                navigationController.changeIndex(1);
              }),

              // SizedBox(height: Get.height * 0.015),
              // commonViewAllAndTitle(title: AppString.liveAuction, images: AppIcons.auction,
              //     onTap: ()
              //     {
              //       AppLogs.log("Live Auction");
              //       Get.to(()=>LiveAuction(),
              //         transition: Transition.rightToLeft
              //       );
              //     }),
              // SizedBox(height: Get.height * 0.015),
              // commonLiveAuction((){
              //   AppLogs.log("Live Auction");
              //   Get.to(()=>ProductDetailsScreen(),
              //       transition: Transition.rightToLeft
              //   );
              // }),
              SizedBox(height: Get.height * 0.020),
              commonViewAllAndTitle(title: AppString.newCategories, images: AppIcons.menu,
                  onTap: () {
                AppLogs.log("New Categories");
                Get.to(()=>NewCategories(),
                    transition: Transition.rightToLeft
                );
              }),
              SizedBox(height: Get.height * 0.020),
              commonNewCategoriesListName((){
                // AppLogs.log("New Categories List");
                // Get.to(()=>ProductDetailsScreen(),
                // );
              }),
              SizedBox(height: Get.height * 0.015),
            Obx(()=>  commonNewCategoriesAndPopular(title: 'New Categories',onTap: (){
                AppLogs.log("New Categories List");
                Get.to(()=>ProductDetailsScreen(),
                );
              }),
            ),
              SizedBox(height: Get.height * 0.015),
              commonViewAllAndTitle(title: AppString.popularProducts, onTap: () {
                AppLogs.log("Popular Products");
                AppLogs.log("Popular Products");
                Get.to(()=>PopularProduct(),
                    transition: Transition.rightToLeft
                );
                }, images:'',),
              SizedBox(height: Get.height * 0.015),
             Obx(()=> commonNewCategoriesAndPopular(title: 'Popular Products', onTap: () {
                AppLogs.log("Popular Products");
                Get.to(()=>ProductDetailsScreen(),
                    transition: Transition.rightToLeft
                );
              }),
             ),
              SizedBox(height: Get.height * 0.015),
              AppText(AppString.justForYou, fontWeight: FontWeight.w600),
             Obx(()=> commonJustForYou((){
                Get.to(()=>ProductDetailsScreen(),
                    transition: Transition.rightToLeft
                );
              }),
             )
            ],
          ),
        ),
      ),
    );
  }

  Widget commonViewAllAndTitle({
    required String title,
    required String images,
    required Function() onTap,
  }) {
    return Row(
      children: [
        if (images.isNotEmpty) ...[
          AppImage.svg(images, height: Get.height * 0.030),
          SizedBox(width: Get.width * 0.015),
        ],
        AppText(title, fontWeight: FontWeight.w600),
         Spacer(),
        GestureDetector(
          onTap: onTap,
          child: AppText(
            AppString.viewAll,
            fontWeight: FontWeight.w600,
            color: AppColor.primary,
          ),
        ),
      ],
    );
  }


  Widget commonLiveSelling(Function() onTap) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.liveSellerList.length,
        itemBuilder: (BuildContext context, int index) {
          final data = homeController.liveSellerList[index];
          AppLogs.log("data $data");
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: DottedBorder(
              options: CircularDottedBorderOptions(strokeWidth: 1,color: AppColor.primary),
              child: GestureDetector(
                onTap: onTap,
                child: ClipOval(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: AppImage.network(
                      data.image ?? "",
                      fit: BoxFit.cover,
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

  Widget commonShorts(Function()? Function) {
    return SizedBox(
      height: Get.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.reelsResponse.length,
        itemBuilder: (BuildContext context, int index) {
          final reel = homeController.reelsResponse[index];
          AppLogs.log("reel $reel");
          return Padding(
            padding: EdgeInsets.only(
              right: Get.width * 0.05,
            ),
            child: GestureDetector(
              onTap: Function,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: Get.width * 0.35,
                      height: Get.height * 0.3,
                      child: AppImage.network(
                        "https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: AppImage.svg(AppIcons.play),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget commonLiveAuction(Function() onTap) {
    return SizedBox(
      height: Get.height * 0.23,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: Get.width * 0.35,
              margin: EdgeInsets.only(right: Get.width * 0.04,bottom: 5),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: AppImage.network(
                      width: double.infinity,
                      height: Get.height * 0.14,
                      'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        "7 day left",
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
      ),
    );
  }

  Widget commonNewCategoriesListName(Function() onTap) {
    return SizedBox(
        height: Get.height * 0.06,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding:  EdgeInsets.only(right: 10),
          itemBuilder: (BuildContext context, int index) {

            AppLogs.log(
                "Selected index: ${homeController.selectedIndex.value == index}");
            return Obx(()=> Padding(
              padding: EdgeInsets.only(
                right: Get.width * 0.035,
                // top: Get.height * 0.019,
              ),
              child: GestureDetector(
                onTap: (){
                  homeController.selectedIndex.value = index;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04,
                    vertical: Get.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: homeController.selectedIndex.value == index ? Colors.black : AppColor.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      if (homeController.selectedIndex.value == index)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset:  Offset(0, 3),
                        ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      child: AppText(
                        "Hello & Hello",
                        fontSize: Get.height * 0.018,
                        color: homeController.selectedIndex.value == index
                            ? Colors.white
                            : AppColor.textWhite.withValues(alpha: 0.9),
                        fontWeight:
                        homeController.selectedIndex.value == index ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
            );
          },
        ),
      );
  }


  Widget commonNewCategoriesAndPopular({
    String? title,
    required Function() onTap,
  }) {
    bool showLike = title != 'Popular Products';
    return SizedBox(
      height: Get.height * 0.24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.newCollectionProduct.length,
        padding:  EdgeInsets.only(right: 10),
        itemBuilder: (BuildContext context, int index) {
          final data = homeController.newCollectionProduct[index];
          AppLogs.log("data NewCollection $data");
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: Get.width * 0.38,
              margin:  EdgeInsets.only(right: 14,bottom: 4),
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
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: AppImage.network(
                          data.mainImage,
                          width: double.infinity,
                          height: Get.height * 0.14,
                          fit: BoxFit.cover,
                        ),
                      ),

                      if (showLike)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: () {
                              homeController.like(data);   // ← only on tap
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                data.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: data.isFavorite ? Colors.red : Colors.black54,
                              ),
                            ),
                          ),
                        ),

                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                       EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppText(
                              data.productName,
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
                                 Spacer(),
                                AppImage.svg(
                                  AppIcons.star,
                                  height: Get.height * 0.020,
                                  color: Colors.yellow,
                                ),
                                AppText(
                                  data.review == 0 ? 'No Reviews' : '${data.review} Reviews',
                                  fontSize: Get.height * 0.013,
                                  color: AppColor.textBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Get.height * 0.005),
                          Expanded(
                            child: AppText(
                              data.description,
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


  Widget commonJustForYou(Function() onTap) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: homeController.justForYouProduct.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final just = homeController.justForYouProduct[index];

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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: AppImage.network(
                      just.mainImage.toString(),
                      width: Get.width * 0.25,
                      height: Get.height * 0.10,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(width: Get.width * 0.030),

                  /// Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Product Name
                        AppText(
                          just.productName.toString(),
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: Get.height * 0.008),

                        /// 🔥 Attributes (Perfect Working)
                        SizedBox(
                          height: Get.height * 0.03,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: just.attributes.length,
                            itemBuilder: (context, attrIndex) {
                              final attr = just.attributes[attrIndex];
                              return Row(
                                children: attr.value.map((v) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 8),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: AppText(
                                      v.toString(),
                                      fontSize: Get.height * 0.010,
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: Get.height * 0.008),

                        /// Price
                        AppText(
                          '\$${just.price ?? 0}',
                          fontSize: Get.height * 0.014,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: Get.height * 0.008),

                        /// Reviews
                        Row(
                          children: [
                            AppImage.svg(
                              AppIcons.star,
                              height: Get.height * 0.020,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: Get.width * 0.010),
                            AppText(
                              just.review == 0
                                  ? 'No Reviews'
                                  : '${just.review} Reviews',
                              fontSize: Get.height * 0.012,
                              color: AppColor.textBlack,
                            ),
                          ],
                        ),
                      ],
                    ),
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
