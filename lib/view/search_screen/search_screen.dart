import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  TextEditingController searchEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: "Search"),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.030,
          vertical: Get.height * 0.010,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              child: TextFormField(
                controller: searchEditingController,
                cursorColor: Colors.black,
                style: TextStyle(
                  color: AppColor.textBlack,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "Search for Products & More",
                  hintStyle: TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 13,
                  ),

                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10), // vadhare height mate
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
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 50,
                    minHeight: 50, // HEIGHT force kari dey chhe
                  ),

                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: AppImage.svg(AppIcons.filter, height: 16),
                  ),

                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 35,
                    minHeight: 35,
                  ),

                  // 🔥 MAIN HEIGHT PROPERTY
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 22, // HEIGHT ↑↑ increase
                  ),

                  filled: true,
                  fillColor: AppColor.textWhite.withValues(alpha: 0.1),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            )

          ],
        )

      ),
    );
  }
}
