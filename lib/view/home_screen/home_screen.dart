import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/app_storage.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/common_appbar.dart';
import 'package:trendycart/view/home_screen/controller/home_controller.dart';
import 'package:trendycart/view/live_screen/live_screen.dart';
import 'package:trendycart/view/new_categories/new_categories.dart';
import 'package:trendycart/view/notification_screen/notification_screen.dart';
import 'package:trendycart/view/popular_products/popular_product.dart';
import 'package:trendycart/view/product_details_screen/product_details_screen.dart';
import 'package:trendycart/view/search_screen/search_screen.dart';
import '../../main.dart';
import '../../utils/common_font.dart';
import '../bottom_bar/controller/bottom_controller.dart';
import '../shorts_screen/controller/shorts_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final ShortsController shortsController = Get.put(ShortsController());
  TextEditingController searchEditingController = TextEditingController();

  bool select = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.loadDefaultCategoryProducts();
    shortsController.reelsMethods();
    AppLogs.log("Home Screen");
  }


  NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value:  SystemUiOverlayStyle(
          statusBarColor: Color(0xffffdabe),
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: AppColor.background,
          appBar: CommonAppBar(
            name: "",
            actions: [
              Padding(
                padding: EdgeInsets.only(right: Get.width * 0.07),
                child: Row(
                  children: [
                    SizedBox(width: Get.width * 0.040),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => NotificationScreen(),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: AppImage.svg(AppIcons.notification, height: 26),
                    ),
                  ],
                ),
              ),
            ],
            onTap: () {
              navigationController.changeIndex(4);
            },
            image: AppIcons.title,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.040,
                vertical: Get.height * 0.010,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SearchScreen(),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.2),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.search, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(child: AppText("Search for Products & More",fontFamily: AppFont.medium,)),
                              ],
                            ),
                          ),
                        ),
                  ),
                  SizedBox(height: Get.height * 0.020),
                  commonViewAllAndTitle(
                    title: AppString.newCategories,
                    images: '',
                    onTap: () {
                      AppLogs.log("New Category");
                      Get.to(
                        () => NewCategories(),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                  SizedBox(height: Get.height * 0.020),
                  Obx(
                    () => commonNewCategoriesListName((catId) {
                      // homeController.getRelatedProductsByCategory(catId);
                    }),
                  ),
                  if (homeController.liveSellerResponse.isNotEmpty)
                    Column(
                      children: [
                        Row(
                          children: [
                            AppImage.svg(AppIcons.liveSelling),
                            SizedBox(width: Get.width * 0.025),
                            AppText(
                              AppString.liveSelling,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.020),
                        Obx(() => commonLiveSelling(() {})),
                        SizedBox(height: Get.height * 0.020),
                      ],
                    ),
                  commonViewAllAndTitle(
                    title: AppString.shorts,
                    images: AppIcons.menu,
                    onTap: () {
                      AppLogs.log("Short");
                      navigationController.changeIndex(1);
                    },
                  ),
                  SizedBox(height: Get.height * 0.020),
                  Obx(
                    () => commonShorts(() {
                      navigationController.changeIndex(1);
                    }),
                  ),
                  SizedBox(height: Get.height * 0.020),
                  commonViewAllAndTitle(
                    title: AppString.liveAuction,
                    images: AppIcons.liveAuction,
                    onTap: () {
                      AppLogs.log("Live Auction");
                      Get.to(
                        () => NewCategories(),
                        transition: Transition.rightToLeft,
                      );
                    },
                  ),
                  SizedBox(height: Get.height * 0.020),
                  Obx(
                    () => newCollectionList(
                      onTap: (productData) {
                        Get.to(
                          () => ProductDetailsScreen(productData: productData),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.020),
                  commonViewAllAndTitle(
                    title: AppString.popularProducts,
                    onTap: () {
                      AppLogs.log("Popular Products");
                      Get.to(
                        () => PopularProduct(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    images: AppIcons.popular,
                  ),
                  SizedBox(height: Get.height * 0.020),
                  Obx(
                    () => popularProductsList(
                      onTap: (productData) {
                        Get.to(
                          () => ProductDetailsScreen(productData: productData),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.020),
                  AppText(AppString.justForYou, fontWeight: FontWeight.w600),
                  Obx(
                    () => commonJustForYou((just) {
                      Get.to(() => ProductDetailsScreen(productData: just),transition: Transition.rightToLeft);
                    }),
                  ),
                ],
              ),
            ),
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
        Expanded(child: AppText(title, fontFamily: AppFont.bold, fontSize: 16)),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: AppText(
            AppString.seeAll,
            fontFamily: AppFont.semiBold,
            color: Colors.grey,
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
        itemCount: homeController.liveSellerResponse.length,
        itemBuilder: (BuildContext context, int index) {
          final data = homeController.liveSellerResponse[index];
          AppLogs.log("data $data");
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: DottedBorder(
              options: CircularDottedBorderOptions(
                strokeWidth: 1,
                color: AppColor.primary,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => LiveScreen(
                      video: data.video,
                      name: data.firstName,
                      view: data.view.toString(),
                    ),
                  );
                },
                child: ClipOval(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: AppImage.network(data.image, fit: BoxFit.cover),
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
      height: Get.height * 0.20,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: shortsController.reel.length,
        itemBuilder: (BuildContext context, int index) {
          final reel = shortsController.reel[index];
          AppLogs.log("reel get  $reel");
          return Padding(
            padding: EdgeInsets.only(right: Get.width * 0.05),
            child: GestureDetector(
              onTap: Function,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    SizedBox(
                      width: Get.width * 0.35,
                      height: Get.height * 0.21,
                      child: AppImage.network(
                        reel.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText("85k View", color: AppColor.textWhite,fontFamily: AppFont.medium,),
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

  Widget commonNewCategoriesListName(Function(String catId) onTap) {
    return SizedBox(
      height: Get.height * 0.12,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.categoryList.length,
        itemBuilder: (context, index) {
          final category = homeController.categoryList[index];
          return Obx(
            () => GestureDetector(
              onTap: () {
                homeController.selectedIndex.value = index;
                homeController.relatedProduct(
                  categoryId: category.id,
                  productId: homeController.justForYouProduct[index].id ?? "",
                );
                onTap(category.id);
              },
              child: Container(
                width: Get.width * 0.24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   index == 0 ? Container(
                     decoration: BoxDecoration(
                       gradient: homeController.selectedIndex.value == index
                           ? AppColor.primaryGradient
                           : LinearGradient(
                         colors: [Colors.white, Colors.white],
                       ),
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: Padding(
                       padding:  EdgeInsets.all(15),
                       child: AppImage.svg(
                           index == 0
                               ? AppIcons.fashion
                               : index == 1
                               ? AppIcons.homeLiving
                               : index == 2
                               ? AppIcons.electronic
                               : index == 3
                               ? AppIcons.footwear
                               : '',
                           height: 28,
                           width: 28,
                            // color:  AppColor.primary
                       ),
                     ),
                   )  : Container(
                      decoration: BoxDecoration(
                        gradient: homeController.selectedIndex.value == index
                            ? AppColor.primaryGradient
                            : LinearGradient(
                                colors: [Colors.white, Colors.white],
                              ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: AppImage.svg(
                          index == 0
                              ? AppIcons.fashion
                              : index == 1
                              ? AppIcons.homeLiving
                              : index == 2
                              ? AppIcons.electronic
                              : index == 3
                              ? AppIcons.footwear
                              : '',
                          height: 28,
                          width: 28,
                          color: homeController.selectedIndex.value == index ? Colors.white : AppColor.primary
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Flexible(
                      child: AppText(
                        category.name,
                        fontSize: Get.height * 0.014,
                        color: AppColor.textBlack,
                        fontFamily: AppFont.semiBold,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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

  Widget newCollectionList({required Function(dynamic data) onTap}) {
    return SizedBox(
      height: Get.height * 0.26,
      child: homeController.relatedProductList.isEmpty
          ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage.svg(AppIcons.noData),
          SizedBox(height: 15,),
          AppText("No Data",fontFamily: AppFont.semiBold,color: Colors.grey,),
        ],
      ))
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
                                SizedBox(height: 10),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AppText(
                                          "\$ $price",
                                          fontSize: Get.height * 0.016,
                                          color: AppColor.price,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      AppImage.svg(
                                        AppIcons.star,
                                        height: Get.height * 0.020,
                                        color: Colors.yellow,
                                      ),
                                      Expanded(
                                        child: AppText(
                                          "No Review",
                                          fontFamily: AppFont.regular,
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: Get.height * 0.014,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8),
                                Expanded(
                                  child: AppText(
                                    desc,
                                    fontSize: Get.height * 0.013,
                                    color: Colors.grey[700],
                                    fontFamily: AppFont.regular,
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

  Widget popularProductsList({required Function(dynamic data) onTap}) {
    return SizedBox(
      height: Get.height * 0.24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.justForYouProduct.length,
        itemBuilder: (context, index) {
          final data = homeController.justForYouProduct[index];
          final image = data.mainImage ?? "";
          final name = data.productName ?? "";
          final price = data.price ?? 0;
          return GestureDetector(
            onTap: () => onTap(data),
            child: Container(
              width: Get.width * 0.40,
              margin: const EdgeInsets.only(right: 14, bottom: 4),
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
                mainAxisSize: MainAxisSize.min,
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            fontSize: Get.height * 0.014,
                            fontFamily: AppFont.bold,
                            color: AppColor.textBlack,
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: Row(
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

  Widget commonJustForYou(Function(dynamic product) onTap) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: homeController.justForYouProduct.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final just = homeController.justForYouProduct[index];
        return GestureDetector(
          onTap: (() => onTap(just)),
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
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: AppImage.network(
                      just.mainImage.toString(),
                      width: Get.width * 0.28,
                      height: Get.height * 0.11,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: Get.width * 0.030),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: AppText(
                                just.productName.toString(),
                                fontFamily: AppFont.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
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
                                  fontFamily:AppFont.bold,
                                  color: AppColor.textBlack,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.012),
                        SizedBox(
                          height: Get.height * 0.03,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: just.attributes.length,
                            itemBuilder: (context, attrIndex) {
                              final attr = just.attributes[attrIndex];
                              return Row(
                                children: attr.values.map((v) {
                                  return Container(
                                    margin:  EdgeInsets.only(right: 8),
                                    padding:  EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.8),
                                      borderRadius: BorderRadius.circular(100),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withValues(alpha: 0.2),
                                          spreadRadius: 0,
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: AppText(
                                      v.toString(),
                                      fontFamily: AppFont.medium,
                                      fontSize: Get.height * 0.010,
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: Get.height * 0.012),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              '\$ ${just.price}',
                              fontSize: Get.height * 0.014,
                              color: AppColor.price,
                              fontFamily: AppFont.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0,right: 12,top: 4,bottom: 4),
                                child: AppText(
                                  "Buy",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: Get.height * 0.014,
                                  color: AppColor.textWhite,
                                  fontWeight:FontWeight.bold,
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
          ),
        );
      },
    );
  }
}
