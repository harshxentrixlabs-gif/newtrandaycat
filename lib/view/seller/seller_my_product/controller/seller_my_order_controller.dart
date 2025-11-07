import 'package:get/get.dart';

class SellerMyProductController extends GetxController{
  RxInt selectedIndex = 0.obs;

  List<String> oderList = [
   "All",
    "Buy Now",
    "Auction",
    "DeActivate"
  ];

}