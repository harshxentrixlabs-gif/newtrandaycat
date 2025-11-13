import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/app_string/app_string.dart';

import '../../login_screen/login_screen.dart';
import '../../navigation_menu/navigation_menu.dart';

class SplashScreenController extends GetxController {
  PageController controller = PageController();


  RxInt dotsIndicator = 0.obs;



  List<String> imageList = [
    "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
    "https://images.unsplash.com/photo-1519125323398-675f0ddb6308",
    "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
  ];

  List<String> textLis = [
    AppString.makeItFashionable,
    AppString.shopTheModernEssentials,
    AppString.newClothsNewPassion,
  ];

  List<String> textLisSeconde = [
    AppString.withnewFashionStyle,
    AppString.withMostModernFashionStyle,
    AppString.withFreshFashionTastes,
  ];

}
