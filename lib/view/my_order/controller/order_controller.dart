import 'dart:developer' as AppLogs;

import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart' hide ApiResponse;
import '../model/my_order.dart';

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





  RxList<OrderData> order = <OrderData>[].obs;

  Future<void> fetchMyOrder() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.myOrder}?userId=691471fbf4b6f3b0fa2d0151&status=Pending",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        final apiResponse = ApiResponse.fromJson(jsonResponse);

        /// <-- FIXED
        order.value = apiResponse.orderData;

        AppLogs.log("✅ Order List Loaded: ${order.length} items");
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      AppLogs.log("➡️ Fetch Products Finally");
    }
  }


}
