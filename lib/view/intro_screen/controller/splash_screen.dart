import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_icons.dart';

import '../../login_screen/login_screen.dart';

class SplashScreenController extends GetxController {
  PageController controller = PageController();


  RxInt dotsIndicator = 0.obs;



  List<String> imageList = [
    AppIcons.first,
    AppIcons.tow,
    AppIcons.three,
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
