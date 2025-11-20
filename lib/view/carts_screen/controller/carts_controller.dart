import 'dart:developer' as AppLogs;

import 'package:get/get.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../model/cart_model.dart';

class CartsController extends GetxController {

  var count = 0.obs;
  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }
  RxBool isLoading = false.obs;
  RxBool isDeleting = false.obs;

  RxList<CartItem> cartList = <CartItem>[].obs;
  Future<void> getCartList() async {
    try {
      isLoading.value = true;
      final api = AppApi.getInstance();
      final response = await api.get(
        "${ApiConfig.getCart}?userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('[ getCartList ] STATUS CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("[ getCartList ] cart map => ${response.data}");
        /// Parse to CartModel
        final cartModel = CartModel.fromJson(jsonResponse["data"] ?? jsonResponse["cart"] ?? jsonResponse);;

        /// `items` is List<CartItem>
        cartList.value = cartModel.items;

        AppLogs.log("[getCartList] ✅ Loaded: ${cartList.length} cart items");

      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("[getCartList] ❌ Error: $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("➡️ Fetch Products Finally");
    }
  }

  Future<void> deleteCart() async {
    try {
      isDeleting.value = true;
      final api = AppApi.getInstance();
      await api.delete(
        "${ApiConfig.deleteCart}?userId=691aaefdf4b6f3b0fa2d1060",
      );
    }catch(e)
    {
      AppLogs.log("Error $e");
    } finally  {
      isDeleting.value = false;
  }
  }


}
