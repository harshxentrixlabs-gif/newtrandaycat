import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';

import '../../main.dart';
import '../../utils/common_font.dart';
import '../carts_screen/carts_screen.dart';
import '../home_screen/controller/home_controller.dart';
import '../home_screen/home_screen.dart';
import '../like_screen/like_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../shorts_screen/shorts_screen.dart';
import 'controller/bottom_controller.dart';

class NavigationMenu extends StatefulWidget {
  NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final NavigationController controller = Get.put(NavigationController());
  final HomeController homeController = Get.put(HomeController());

  final List<Widget> pages = const [
    HomeScreen(),
    ShortsScreen(),
    CartsScreen(),
    LikeScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    AppLogs.log("Navigation");
  }

  Widget navItem({
    required String icon,
    required String label,
    required bool isSelected,
  }) {
    return SizedBox(
      height: 55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected)
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primary,
                    ),
                    child: Center(
                      child: AppImage.svg(
                        icon,
                        color: Colors.white,
                        height: controller.currentIndex.value == 3 ? 14 : 18,
                        width: 18,
                      ),
                    ),
                  )
                else
                  AppImage.svg(
                    icon,
                    color: Colors.grey,
                    height: controller.currentIndex.value == 3 ? 18 :  22,
                    width: 22,
                  ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Expanded(
            child: AppText(
              label,
              fontSize: 12,
              fontFamily: AppFont.semiBold,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Obx(
          () => WillPopScope(
        onWillPop: controller.onWillPop,
        child: AnnotatedRegion(
          value: const SystemUiOverlayStyle(
            statusBarColor: Color(0xffffdabe),
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: controller.currentIndex.value == 1 ? Colors.transparent : Colors.white,
            body: pages[controller.currentIndex.value],
            bottomNavigationBar: Container(
              decoration:  BoxDecoration(
                color: controller.currentIndex.value == 1 ?  Colors.white.withValues(alpha: 0.12) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: BottomNavigationBar(
                  backgroundColor:controller.currentIndex.value == 1 ? Colors.white.withValues(alpha: 0.12) : Colors.white,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: controller.currentIndex.value,
                  onTap: controller.changeIndex,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                      icon: navItem(
                        icon: AppIcons.home,
                        label: "Home",
                        isSelected: controller.currentIndex.value == 0,
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: navItem(
                        icon: AppIcons.reels,
                        label: "Reels",
                        isSelected: controller.currentIndex.value == 1,
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: navItem(
                        icon: AppIcons.cart,
                        label: "Cart",
                        isSelected: controller.currentIndex.value == 2,
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: navItem(
                        icon: AppIcons.heart,
                        label: "Wishlist",
                        isSelected: controller.currentIndex.value == 3,
                      ),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: navItem(
                        icon: AppIcons.profile,
                        label: "Profile",
                        isSelected: controller.currentIndex.value == 4,
                      ),
                      label: "",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
