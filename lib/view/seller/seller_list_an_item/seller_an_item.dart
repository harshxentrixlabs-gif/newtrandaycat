import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
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
      appBar: AppAppBar(title: AppString.listingSummary),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050,
            vertical: Get.height * 0.020,
          ),
          child: Column(
            children: [
              commonTitleAndIcon(AppString.photos, () {}),
              SizedBox(height: Get.height * 0.020),
              Row(
                children: [
                  Icon(Icons.ac_unit_outlined),
                  SizedBox(width: Get.width * 0.020),
                  AppText(
                    AppString.pleaseProvidePhotosForYourItem,
                    fontSize: Get.height * 0.012,
                  ),
                  SizedBox(height: Get.height * 0.020),
                ],
              ),
              SizedBox(height: Get.height * 0.020),
              Obx(() {
                if (listANItemController.pickedImages.isEmpty) {
                  return commonSubTitleAndIcons(
                    AppString.uploadPhotos,
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
                    AppString.takePhotos,
                    Icons.camera_alt,
                    () {},
                  );
                }
                return SizedBox(height: Get.height * 0.020);
              }),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon(AppString.title, () {}),
              SizedBox(height: Get.height * 0.020),
              commonText(AppString.pleaseProvideATitleForYourItem),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon(AppString.category, () {}),
              SizedBox(height: Get.height * 0.020),
              commonText(AppString.pleaseProvideACategoryForYourItem),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon(AppString.itemSpecific, () {}),
              SizedBox(height: Get.height * 0.020),
              commonText(AppString.additionalSpecificAreRequired),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon(AppString.description, () {}),
              SizedBox(height: Get.height * 0.020),
              commonText(AppString.pleaseProvideADescriptiveTitleForYourItem),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon(AppString.pricing, () {}),
              SizedBox(height: Get.height * 0.020),
              commonText(AppString.pleaseProvideAStartingBidForYourItem),
              SizedBox(height: Get.height * 0.020),
              commonTitleAndIcon(AppString.preferences, () {}),
              SizedBox(height: Get.height * 0.020),
              commonText(AppString.pleaseProvideAPreferencesForYourItem),
              SizedBox(height: Get.height * 0.030),
              CommonButton(title: AppString.listAnItem),
              SizedBox(height: Get.height * 0.020),
              OutlineWhiteButton(text: AppString.preview, onTap: () {}),
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
