import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.030,
          vertical: Get.height * 0.04,
        ),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){Get.back();},
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primary.withValues(alpha: 0.25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: TextFormField(
                      controller: searchEditingController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: AppColor.textBlack, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Write here...",
                        hintStyle: TextStyle(
                          color: AppColor.textSecondary,
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 20,
                        ),
                        suffixIcon: Padding(
                          padding:  EdgeInsets.all(12.0),
                          child: AppImage.svg(AppIcons.filter),
                        ),
                        filled: true,
                        fillColor: AppColor.primary.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
