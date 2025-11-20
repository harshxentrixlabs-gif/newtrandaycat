import 'dart:developer' as AppLogs;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';

import '../../utils/common/app_image.dart';
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
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: AppText(
          AppString.carts,
          fontSize: Get.height * 0.020,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Column(
          children: [
            DottedBorder(
              options: CustomPathDottedBorderOptions(
                padding: EdgeInsets.all(8),
                color: Colors.black,
                strokeWidth: 2,
                dashPattern: [10, 5],
                customPath: (size) => Path()
                  ..moveTo(0, size.height)
                  ..relativeLineTo(size.width, 0),
              ),
              child: Container(),
            ),
            SizedBox(height: Get.height * 0.010),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.03,
                vertical: Get.height * 0.002,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(AppString.amount),
                      AppText(
                        '\$3000',
                        fontSize: Get.height * 0.014,
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.010),
                  CommonButton(
                    title: AppString.checkOut,
                    onTap: () {
                      AppLogs.log("CheckOut >>");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.020,vertical: 10),
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
          child: Center(
            child: CircularProgressIndicator()
          ),
        );
      }
      if (cartsController.cartList.isEmpty) {
        return SizedBox(
          height: Get.height * 0.70,
          child: Center(
            child: AppText(
              "No data",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }

      // ------------------ CART LIST -------------------
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
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: Get.height * 0.008),

                          Row(
                            children: [
                              AppText("Color : "),
                              AppText(
                                "White",
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              )
                            ],
                          ),

                          SizedBox(height: Get.height * 0.010),

                          Row(
                            children: [
                              AppText(
                                '\$3000',
                                fontWeight: FontWeight.bold,
                                color: AppColor.primary,
                              ),
                              Spacer(),

                              Container(
                                height: Get.height * 0.04,
                                width: Get.width * 0.20,
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (cartsController.count.value == 0) {
                                          cartsController.deleteCart();
                                        } else {
                                          cartsController.decrement();
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Obx(() {
                                          return cartsController.isDeleting.value
                                              ? SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: AppColor.primary,
                                            ),
                                          )
                                              : Icon(
                                            Icons.remove,
                                            size: Get.height * 0.015,
                                            color: AppColor.primary,
                                          );
                                        }),
                                      ),
                                    ),

                                    Obx(
                                          () => AppText(
                                        "${cartsController.count.value}",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () => cartsController.increment(),
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: Get.height * 0.015,
                                          color: AppColor.primary,
                                        ),
                                      ),
                                    ),
                                  ],
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
    });
  }

}
