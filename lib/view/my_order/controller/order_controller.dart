import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';

class OrderController extends GetxController {
  RxInt selectedIndex = 0.obs;

  List<String> oderList = [
    AppString.all,
    AppString.pending,
    AppString.confirmed,
    AppString.outOfDelivery,
    AppString.delivered,
    AppString.cancelled,
    AppString.manualAuctionPendingPayment,
    AppString.manualAuctionCancelled,
    AppString.auctionPendingPayment,
    AppString.auctionCancelled
  ];
}
