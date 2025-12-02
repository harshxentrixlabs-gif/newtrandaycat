import 'package:flutter/material.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_image.dart';
import '../../utils/app_color.dart';
import '../../utils/common_font.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  // Dummy Notification list
  final List<Map<String, String>> notificationList = [
    // {
    //   "image": "assets/images/offer.png",
    //   "title": "Big Discount on Your Wishlist!",
    // },
    // {
    //   "image": "assets/images/order.png",
    //   "title": "Your Order Has Been Shipped",
    // },
    // {
    //   "image": "assets/images/notify.png",
    //   "title": "New Arrivals Just For You",
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar:  AppAppBar(title: "Notification"),
      body: notificationList.isEmpty
          ? Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage.svg(AppIcons.noData),
              SizedBox(height: 15,),
              AppText("No Notification",fontFamily:AppFont.semiBold,),
            ],
          ))
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          final item = notificationList[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: AppImage.network(
                      "",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      item["title"]!,
                      color: AppColor.textBlack,
                      fontSize: 14,
                      fontFamily: AppFont.bold,
                    ),
                    SizedBox(height: 5,),
                    AppText(
                      "2h ago",
                      color: AppColor.textBlack,
                      fontSize: 12,
                      fontFamily: AppFont.medium,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
