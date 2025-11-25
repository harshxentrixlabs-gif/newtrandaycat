import 'dart:developer' as AppLogs;
import 'package:get/get.dart';
import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../model/cart_model.dart';

class CartsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDeleting = false.obs;
  RxBool isUpdatingQty = false.obs;

  Rx<CartModel?> cartModel = Rx<CartModel?>(null);
  RxList<CartItem> cartList = <CartItem>[].obs;

  String userId = "691aaefdf4b6f3b0fa2d1060";     // <-- change this

  // -----------------------------------------------------
  // 🔥 GET CART LIST
  // -----------------------------------------------------
  Future<void> getCartList() async {
    try {
      isLoading.value = true;
      final api = AppApi.getInstance();

      final response = await api.get("${ApiConfig.getCart}?userId=$userId");

      if (response.statusCode == 200) {
        final jsonResponse = response.data;

        final model = CartModel.fromJson(
          jsonResponse["data"] ?? jsonResponse["cart"] ?? jsonResponse,
        );

        cartModel.value = model;
        cartList.value = model.items;

        AppLogs.log("[getCartList] DONE: ${cartList.length} items");
      }
    } catch (e) {
      AppLogs.log("Error $e");
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------------------------------
  // 🔥 UPDATE CART QUANTITY (PATCH CALL)
  // -----------------------------------------------------
  Future<void> updateQuantityAPI({
    required CartItem item,
    required int newQty,
  }) async {
    try {
      AppLogs.log("Update");
      isUpdatingQty.value = true;

      final api = AppApi.getInstance();

      final body = {
        "userId": "691aaefdf4b6f3b0fa2d1060",
        "productId": item.productId.id,
        "productQuantity": newQty,
        "attributesArray": item.attributesArray,
      };

      AppLogs.log("PATCH BODY : $body");

      final response = await api.patch(
        ApiConfig.removeTOCart,
        data: body,
      );

      AppLogs.log("PATCH STATUS: ${response.statusCode}");
      AppLogs.log("PATCH RESPONSE: ${response.data}");
    } catch (e) {
      AppLogs.log("PATCH ERROR: $e");
    } finally {
      isUpdatingQty.value = false;
    }
  }

  // -----------------------------------------------------
  // 🔥 INCREMENT QTY + CALL API
  // -----------------------------------------------------
  void incrementQuantity(int index) async {
    final item = cartList[index];
    final newQty = item.productQuantity + 1;

    // Local update
    cartList[index] = item.copyWith(productQuantity: newQty);
    calculateTotal();

    // API update
    await updateQuantityAPI(item: item, newQty: newQty);
  }

  // -----------------------------------------------------
  // 🔥 DECREMENT QTY + CALL API
  // -----------------------------------------------------
  void decrementQuantity(int index) async {
    final item = cartList[index];

    if (item.productQuantity <= 1) return;

    final newQty = item.productQuantity - 1;

    // Local update
    cartList[index] = item.copyWith(productQuantity: newQty);
    calculateTotal();

    // API update
    await updateQuantityAPI(item: item, newQty: newQty);
  }

  // -----------------------------------------------------
  // 🔥 TOTAL CALCULATION
  // -----------------------------------------------------
  void calculateTotal() {
    int total = 0;

    for (var item in cartList) {
      total += item.purchasedTimeProductPrice * item.productQuantity;
    }

    cartModel.value = cartModel.value?.copyWith(subTotal: total);
  }

  // -----------------------------------------------------
  // 🔥 DELETE FULL CART
  // -----------------------------------------------------
  Future<void> deleteCart() async {
    try {
      isDeleting.value = true;
      final api = AppApi.getInstance();

      await api.delete("${ApiConfig.deleteCart}?userId=$userId");

      cartList.clear();
      cartModel.value = null;

    } catch (e) {
      AppLogs.log("Error $e");
    } finally {
      isDeleting.value = false;
    }
  }
}
