import 'dart:developer' as AppLogs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/view/auction_order_details/auction_order_details.dart';
import '../../utils/app_color.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common/widgets.dart';
import 'controller/order_controller.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    orderController.fetchMyOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.myOrder),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.020),
          commonNewCategoriesListName(),
          Divider(color: Colors.black),
          Expanded(
            child: orderController.order.isEmpty
                ? Center(child: AppText("No Data"))
                : Obx(() => commonCartWidget()),
          ),
        ],
      ),
    );
  }

  Widget commonNewCategoriesListName() {
    return SizedBox(
      height: Get.height * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: orderController.oderList.length,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => Padding(
              padding: EdgeInsets.only(right: Get.width * 0.035),
              child: GestureDetector(
                onTap: () {
                  orderController.selectedIndex.value = index;
                  AppLogs.log(
                    "Selected index: ${orderController.selectedIndex.value}",
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04,
                    vertical: Get.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: orderController.selectedIndex.value == index
                        ? Colors.white
                        : AppColor.primary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      if (orderController.selectedIndex.value == index)
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                    ],
                  ),
                  child: Center(
                    child: AppText(
                      orderController.oderList[index],
                      fontSize: Get.height * 0.014,
                      color: orderController.selectedIndex.value == index
                          ? AppColor.textBlack
                          : AppColor.textWhite.withOpacity(0.9),
                      fontWeight: FontWeight.bold,
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

  Widget commonCartWidget() {
    return Expanded(
      child: ListView.builder(
        itemCount: orderController.order.length,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.020),
        itemBuilder: (BuildContext context, int index) {
          final data = orderController.order[index];
          AppLogs.log("order Data $data");
          return Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.010),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12, width: 1),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: Get.height * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            "Order AU#35363",
                            fontSize: Get.height * 0.015,
                            fontWeight: FontWeight.w600,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: AppText(
                              "AUCTION",
                              fontSize: Get.height * 0.012,
                              color: AppColor.textWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AppImage.network(
                            width: Get.width * 0.20,
                            height: Get.height * 0.08,
                            'https://thrivenextgen.com/wp-content/uploads/AdobeStock_162765779_45-scaled.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: Get.width * 0.035),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      "Hello Product Name",
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.height * 0.016,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: AppText(
                                      "Pending Pay",
                                      fontSize: Get.height * 0.012,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Get.height * 0.020),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    '\$3000',
                                    fontSize: Get.height * 0.014,
                                    color: AppColor.textBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  AppText(
                                    'Qty: 1',
                                    fontSize: Get.height * 0.014,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlineWhiteButton(
                            text: AppString.viewDetails,
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: Get.width * 0.025),
                        Expanded(
                          child: CommonButton(
                            title: "Pay Now",
                            onTap: () {
                              AppLogs.log("Go to Pay Now");
                              Get.to(
                                () => AuctionOrderDetails(),
                                transition: Transition.rightToLeft,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: Get.height * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            "Total",
                            fontSize: Get.height * 0.016,
                            fontWeight: FontWeight.w600,
                          ),
                          AppText(
                            "\$1200",
                            fontSize: Get.height * 0.016,
                            color: AppColor.textBlack,
                            fontWeight: FontWeight.bold,
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
