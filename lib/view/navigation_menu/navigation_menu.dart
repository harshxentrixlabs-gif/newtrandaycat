import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_image.dart';

import '../carts_screen/carts_screen.dart';
import '../home_screen/controller/home_controller.dart';
import '../home_screen/home_screen.dart';
import '../like_screen/like_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../shorts_screen/shorts_screen.dart';
import 'controller/navigation_controller.dart';

class NavigationMenu extends StatefulWidget {
  NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final NavigationController controller = Get.put(NavigationController());
  // final HomeController homeController = Get.find();
  final List<Widget> pages = const [
    HomeScreen(),
    ShortsScreen(),
    CartsScreen(),
    LikeScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppLogs.log("Navigation");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: controller.onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: pages[controller.currentIndex.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
                vertical: Get.height * 0.03,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  elevation: 5,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeIndex,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    _bottomItem(AppIcons.home, 0, () {
                      // homeController.fetchProduct();
                    }),
                    _bottomItem(AppIcons.flash, 1, () {}),
                    _bottomItem(AppIcons.cart, 2, () {}),
                    _bottomItem(AppIcons.heart, 3, () {}),
                    _bottomItem(AppIcons.profile, 4, () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomItem(
    String icon,
    int index,
    Function() onTap,
  ) {
    final isSelected = controller.currentIndex.value == index;
    return BottomNavigationBarItem(
      backgroundColor: Colors.transparent,
      label: '',
      icon: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primary.withValues(alpha: 0.2)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: AppImage.svg(
          icon,
          color: isSelected ? AppColor.primary : Colors.grey,
        ),
      ),
    );
  }
}
