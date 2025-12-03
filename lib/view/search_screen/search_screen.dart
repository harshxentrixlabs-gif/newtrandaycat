import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_loader.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common_font.dart';
import '../product_details_screen/product_details_screen.dart';
import 'controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchEditingController = TextEditingController();
  final SearchScreenController searchController = Get.put(SearchScreenController());

  RxList<dynamic> filteredItems = <dynamic>[].obs;

  @override
  void initState() {
    super.initState();
    ever(searchController.searchList, (_) {
      filteredItems.value = searchController.searchList;
    });
  }

  void _filterList(String query) {
    if (query.isEmpty) {
      filteredItems.value = searchController.searchList;
    } else {
      filteredItems.value =
          searchController.searchList.where((item) =>
              item.productName!.toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: "Search"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.030,
            vertical: Get.height * 0.010,
          ),
          child: Column(
            children: [
              // 🔍 Search Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: searchEditingController,
                  onChanged: _filterList, // 👈 Search Trigger
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Search for Products & More",
                    hintStyle: TextStyle(fontFamily: AppFont.medium),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 10),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                        ),
                        child: AppImage.svg(
                          AppIcons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Obx(() => commonSearch((product) {
                Get.to(() => ProductDetailsScreen(productId: product),transition: Transition.rightToLeft);
              })),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonSearch(Function(dynamic) onTap) {
    if (searchController.searchList.isEmpty) {
      return SizedBox(
        height: Get.height * 0.70,
        child: Center(child: AppLoaderWidget()),
      );
    }

    if (filteredItems.isEmpty) {
      return SizedBox(
        height: Get.height * 0.70,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage.svg(AppIcons.cartImage),
              SizedBox(height: 25),
              AppText("No Data Found",fontFamily: AppFont.semiBold,),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final product = filteredItems[index];
        return GestureDetector(
          onTap: () => onTap(product),
          child: Container(
            margin: EdgeInsets.only(top: Get.height * 0.020),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
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
                    borderRadius: BorderRadius.circular(15),
                    child: AppImage.network(
                      product.mainImage ?? "",
                      width: Get.width * 0.23,
                      height: Get.height * 0.11,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: Get.width * 0.030),
                  Expanded(
                    child: SizedBox(
                      height: Get.height * 0.10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            product.productName ?? "",
                            fontFamily: AppFont.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: Get.height * 0.010),
                          Expanded(
                            child: AppText(
                              product.description ?? "",
                              fontSize: Get.height * 0.011,
                              fontFamily: AppFont.medium,
                              color: Colors.grey,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(
                                  (product.review == 0 || product.review == null)
                                      ? 'No Reviews'
                                      : '${product.review} Reviews',
                                  fontSize: Get.height * 0.012,
                                  color: AppColor.textBlack,
                                  fontFamily: AppFont.semiBold,
                                ),
                                SizedBox(width: 5),
                                AppImage.svg(
                                  AppIcons.eye,
                                  height: Get.height * 0.014,
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
          ),
        );

      },
    );
  }
}
