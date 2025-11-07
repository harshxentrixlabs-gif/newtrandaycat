import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/common_appbar.dart';
import 'package:trendycart/view/home_screen/controller/home_controller.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppLogs.log("Home Screen");
  }
  NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CommonAppBar(
        name: "Harsh",
        subName: "Flutter Developer",
        images: "https://plus.unsplash.com/premium_photo-1690579805307-7ec030c75543?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1170",
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
                  SizedBox(width: Get.width * 0.015),
                  AppText(AppString.liveSelling, fontWeight: FontWeight.w600),
                ],
              ),
              commonLiveSelling((){
                Get.to(()=>LiveScreen());
              }),
              commonViewAllAndTitle(title: AppString.shorts, images: AppIcons.flash, onTap: () {AppLogs.log("Shorts"); navigationController.changeIndex(1); }),
              commonShorts((){
                navigationController.changeIndex(1);
              }),
              SizedBox(height: Get.height * 0.010),
              commonViewAllAndTitle(title: AppString.liveAuction, images: AppIcons.auction,
                  onTap: ()
                  {
                    AppLogs.log("Live Auction");
                    Get.to(()=>LiveAuction(),
                      transition: Transition.rightToLeft
                    );
                  }),
              SizedBox(height: Get.height * 0.010),
              commonLiveAuction((){
                AppLogs.log("Live Auction");
                Get.to(()=>ProductDetailsScreen(),
                    transition: Transition.rightToLeft
                );
              }),
              SizedBox(height: Get.height * 0.020),
              commonViewAllAndTitle(title: AppString.newCategories, images: AppIcons.menu,
                  onTap: () {
                AppLogs.log("New Categories");
                Get.to(()=>NewCategories(),
                    transition: Transition.rightToLeft
                );
              }),
              commonNewCategoriesListName((){
                // AppLogs.log("New Categories List");
                // Get.to(()=>ProductDetailsScreen(),
                // );
              }),
              SizedBox(height: Get.height * 0.020),
              commonNewCategoriesAndPopular(title: 'New Categories',onTap: (){
                AppLogs.log("New Categories List");
                Get.to(()=>ProductDetailsScreen(),
                );
              }),
              SizedBox(height: Get.height * 0.020),
              commonViewAllAndTitle(title: AppString.popularProducts, onTap: () {
                AppLogs.log("Popular Products");
                AppLogs.log("Popular Products");
                Get.to(()=>PopularProduct(),
                    transition: Transition.rightToLeft
                );
                }, images:'',),
              SizedBox(height: Get.height * 0.020),
              commonNewCategoriesAndPopular(title: 'Popular Products', onTap: () {
                AppLogs.log("Popular Products");
                Get.to(()=>ProductDetailsScreen(),
                    transition: Transition.rightToLeft
                );
              }),
              SizedBox(height: Get.height * 0.020),
              AppText(AppString.justForYou, fontWeight: FontWeight.w600),
              commonJustForYou((){
                Get.to(()=>ProductDetailsScreen(),
                    transition: Transition.rightToLeft
                );
              })
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
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
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
                      "https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp",
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
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              right: Get.width * 0.05,
              top: Get.height * 0.010,
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
      height: Get.height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              width: Get.width * 0.35,
              margin: EdgeInsets.only(right: Get.width * 0.04),
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        'Live Selling',
                        fontSize: Get.height * 0.016,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textBlack,
                      ),
                      SizedBox(height: 3),
                      AppText(
                        'Limited Time Offer!',
                        fontSize: Get.height * 0.014,
                        color: AppColor.textBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
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
        height: Get.height * 0.07,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding:  EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (BuildContext context, int index) {
            AppLogs.log(
                "Selected index: ${homeController.selectedIndex.value == index}");
            return Obx(()=> Padding(
              padding: EdgeInsets.only(
                right: Get.width * 0.035,
                top: Get.height * 0.019,
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
      height: Get.height * 0.22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding:  EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (BuildContext context, int index) {
           bool isSelected = false;
          return GestureDetector(
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
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: AppImage.network(
                          'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
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
                              AppLogs.log('Liked item $index');
                            },
                            child: Container(
                              padding:  EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isSelected
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isSelected
                                    ? Colors.redAccent
                                    : Colors.black54,
                                size: 20,
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
                              'Live Selling',
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
                                  '\$3000',
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
                                  '4.5',
                                  fontSize: Get.height * 0.013,
                                  color: AppColor.textBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              'Top Trending Product',
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


  Widget commonJustForYou(Function() onTap){
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
              child: Row(
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
                        SizedBox(
                          height: Get.height * 0.02,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: Get.width * 0.02,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.02,
                                      // vertical: Get.height * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color:  Colors.black ,),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(vertical: Get.height * 0.001),
                                    child: Center(
                                      child: AppText(
                                        "Red",
                                        fontSize: Get.height * 0.008,
                                        color:  AppColor.textBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: Get.height * 0.008,),
                        AppText(
                          '\$3000',
                          fontSize: Get.height * 0.014,
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: Get.height * 0.008,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppImage.svg(AppIcons.star,height: Get.height * 0.020,color: Colors.yellow),
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
            ),
          ),
        );
      },
    );
  }

}
