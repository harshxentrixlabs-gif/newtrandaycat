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

class NewCategories extends StatefulWidget {
  const NewCategories({super.key});

  @override
  State<NewCategories> createState() => _NewCategoriesState();
}

class _NewCategoriesState extends State<NewCategories> {

  final NewCategoriesController newCategoriesController = Get.put(NewCategoriesController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.newCategories),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.010),
        child: Column(
          children: [
            commonNewCategoriesListName((){}),
            SizedBox(height: Get.height * 0.020,),
            commonNewCategories((){})
          ],
        ),
      ),
    );
  }

  Widget commonNewCategoriesListName(Function() onTap) {
    return SizedBox(
      height: Get.height * 0.07,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          AppLogs.log(
              "Selected index: ${newCategoriesController.selectedIndex.value == index}");
          return Obx(()=> Padding(
            padding: EdgeInsets.only(
              right: Get.width * 0.035,
              top: Get.height * 0.019,
            ),
            child: GestureDetector(
              onTap: (){
                newCategoriesController.selectedIndex.value = index;
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04,
                  vertical: Get.height * 0.01,
                ),
                decoration: BoxDecoration(
                  color: newCategoriesController.selectedIndex.value == index ? Colors.black : AppColor.primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    if (newCategoriesController.selectedIndex.value == index)
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
                      color: newCategoriesController.selectedIndex.value == index
                          ? Colors.white
                          : AppColor.textWhite.withValues(alpha: 0.9),
                      fontWeight:
                      newCategoriesController.selectedIndex.value == index ? FontWeight.bold : FontWeight.w500,
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

  Widget commonNewCategories(Function() onTap) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          childAspectRatio: 0.80,
        ),
        itemCount:12,
        itemBuilder: (BuildContext context, int index) {
          return  GestureDetector(
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


                                Icons.favorite_border,color:  Colors.black54,
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
                          AppText(
                            'Live Selling',
                            fontSize: Get.height * 0.014,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textBlack,
                            overflow: TextOverflow.ellipsis,
                          ),
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
}
