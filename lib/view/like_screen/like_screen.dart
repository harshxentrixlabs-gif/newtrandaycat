import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import '../../utils/app_color.dart';
import '../../utils/common/common_appbar.dart';
import '../navigation_menu/controller/navigation_controller.dart';
import 'controller/like_controller.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  NavigationController navigationController = Get.find();
  final box = GetStorage();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      appBar: CommonAppBar(
        name: box.read('userName') ?? "Guest User",
        subName: box.read('userEmail') ?? "",
        images: box.read('userPhoto') ??
            "https://cdn-icons-png.flaticon.com/512/149/149071.png",
        onTap: () => navigationController.changeIndex(4),
      ),

      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             AppText(
              "Wishlist Collection",
              fontSize: 18, fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
