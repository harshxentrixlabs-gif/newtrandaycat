import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';

import '../../../utils/app_color.dart';
import '../../../utils/common/widgets.dart';
import 'controller/list_an_item.dart';

class SellerAnItem extends StatefulWidget {
  const SellerAnItem({super.key});

  @override
  State<SellerAnItem> createState() => _SellerAnItemState();
}

class _SellerAnItemState extends State<SellerAnItem> {
  final ListAnItemController listANItemController = Get.put(
    ListAnItemController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: "Listing Summary"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050,
            vertical: Get.height * 0.020,
          ),
          child: Column(
            children: [
              commonTitleAndIcon("Photos", () {}),
              SizedBox(height: Get.height * 0.020),
              Row(
                children: [
                  Icon(Icons.ac_unit_outlined),
                  SizedBox(width: Get.width * 0.020),
                  AppText(
                    "Please provide photos for your item",
                    fontSize: Get.height * 0.012,
                  ),
                  SizedBox(height: Get.height * 0.020),
                ],
              ),
              SizedBox(height: Get.height * 0.020),
              Obx(() {
                if (listANItemController.pickedImages.isEmpty) {
                  return commonSubTitleAndIcons(
                    "Upload Photos",
                    Icons.upload,
                    () {
                      listANItemController.pickImagesFromGallery();
                    },
                  );
                } else {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          listANItemController.pickImagesFromGallery();
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black.withValues(alpha: 0.2)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listANItemController.pickedImages.length,
                            itemBuilder: (context, index) {
                              final image = listANItemController.pickedImages[index];
                              return Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: FileImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    top: 2,
                                    child: GestureDetector(
                                      onTap: () =>
                                          listANItemController.deletePhoto(index),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
              SizedBox(height: Get.height * 0.020),
              Obx(() {
                if (listANItemController.pickedImages.isEmpty) {
                  return commonSubTitleAndIcons(
                    "Take Photos",
                    Icons.camera_alt,
                    () {},
                  );
                }
                return SizedBox(height: Get.height * 0.020);
              }),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon("Title", () {}),
              SizedBox(height: Get.height * 0.020),
              commonText("Please provide a title for your item"),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon("Category", () {}),
              SizedBox(height: Get.height * 0.020),
              commonText("Please provide a category for your item"),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon("Item Specific", () {}),
              SizedBox(height: Get.height * 0.020),
              commonText("Additional specific are required"),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon("Description", () {}),
              SizedBox(height: Get.height * 0.020),
              commonText("Please provide a descriptive title for your item"),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon("Pricing", () {}),
              SizedBox(height: Get.height * 0.020),
              commonText("Please provide a Starting bid for your item"),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon("Preferences", () {}),
              SizedBox(height: Get.height * 0.020),
              commonText("Please provide a Preferences for your item"),
              SizedBox(height: Get.height * 0.030),
              CommonButton(title: "List an item"),
              SizedBox(height: Get.height * 0.020),
              OutlineWhiteButton(text: 'Preview', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonText(String title) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: AppColor.primary.withValues(alpha: 0.2),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(Icons.ac_unit_outlined),
            SizedBox(width: Get.width * 0.020),
            AppText(title, fontSize: Get.height * 0.012),
            SizedBox(height: Get.height * 0.020),
          ],
        ),
      ),
    );
  }

  Widget commonSubTitleAndIcons(String title, IconData icon, Function() onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: AppColor.primary.withValues(alpha: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(title),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary.withValues(alpha: 0.2),
                ),
                child: Padding(padding: EdgeInsets.all(8.0), child: Icon(icon)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget commonTitleAndIcon(String title, Function() onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          title,
          fontSize: Get.height * 0.018,
          fontWeight: FontWeight.bold,
        ),
        GestureDetector(onTap: onTap, child: Icon(Icons.edit)),
      ],
    );
  }
}
