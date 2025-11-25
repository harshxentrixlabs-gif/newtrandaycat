import 'dart:developer' as AppLogs;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/carts_screen/model/cart_model.dart';

import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';
import '../../utils/globle_veriables.dart';
import 'controller/carts_controller.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  final CartsController cartsController = Get.put(CartsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartsController.getCartList();
    AppLogs.log("Carts Screen");
  }

  @override
  Widget build(BuildContext context) {
    final model = cartsController.cartModel.value;
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Obx(() {
          final model = cartsController.cartModel.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                AppString.carts,
                fontSize: Get.height * 0.020,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                "(${model?.totalItems ?? 0})",
                fontSize: Get.height * 0.020,
                fontWeight: FontWeight.bold,
              ),
            ],
          );
        }),
      ),
      bottomSheet: Obx(() {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.2,
                vertical: Get.height * 0.02,
              ),
              child: Column(
                children: [
                  cartsController.cartList.isEmpty
                      ? const SizedBox()
                      : CommonBlackButton(
                          title: AppString.checkOut,
                          image: AppIcons.back,
                          onTap: () {
                            AppLogs.log("CheckOut >>");
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      }),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.040),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonCarts(),
              SizedBox(height: Get.height * 0.20),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonCarts() {
    return Obx(() {
      if (cartsController.isLoading.value) {
        return SizedBox(
          height: Get.height * 0.70,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (cartsController.cartList.isEmpty) {
        return SizedBox(
          height: Get.height * 0.70,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImage.svg(AppIcons.cartImage),
                SizedBox(height: 25),
                AppText("No Data Found"),
              ],
            ),
          ),
        );
      }
      return ListView.builder(
        itemCount: cartsController.cartList.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final data = cartsController.cartList[index];
          final product = data.productId;
          return GestureDetector(
            onTap: () => AppLogs.log('Tapped item $index'),
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
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: AppImage.network(
                        product.mainImage,
                        width: Get.width * 0.25,
                        height: Get.height * 0.10,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.030),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            product.productName,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: Get.height * 0.008),
                          AppText(product.productName, fontSize: 12),
                          SizedBox(height: Get.height * 0.010),
                          AppText(
                            '\$ ${data.purchasedTimeProductPrice}',
                            fontWeight: FontWeight.bold,
                            color: AppColor.price,
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (data.productQuantity == 1) {
                                  cartsController.deleteCart();
                                  AppLogs.log("if Part ");
                                  cartsController.getCartList();
                                } else {
                                  cartsController.decrementQuantity(index);
                                  AppLogs.log("===============${product.id}");
                                  AppLogs.log("else Part ");
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: Get.height * 0.015,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            AppText(
                              "${data.productQuantity}",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () =>
                                  cartsController.incrementQuantity(index),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: Get.height * 0.015,
                                  color: Colors.grey,
                                ),
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
    });
  }
}
