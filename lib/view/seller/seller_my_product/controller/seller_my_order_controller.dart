import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';

class SellerMyProductController extends GetxController{
  RxInt selectedIndex = 0.obs;

  List<String> oderList = [
     AppString.all,
     AppString.byNow,
     AppString.auction,
     AppString.deActivate
  ];

}