import 'dart:developer' as AppLogs;
import 'package:get/get.dart';
import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../model/cart_model.dart';

class CartsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isUpdatingQty = false.obs;

  Rx<CartModel?> cartModel = Rx<CartModel?>(null);
  RxList<CartItem> cartList = <CartItem>[].obs;

  String userId = "691aaefdf4b6f3b0fa2d1060";

  @override
  void onInit() {
    AppLogs.log("onInit() START");
    getCartList();
    AppLogs.log("onInit() END");
    super.onInit();
  }

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

  Future<bool> updateProductQty({
    required String productId,
    required int quantity,
    required List attributes,
  }) async {
    AppLogs.log("updateProductQty() START");

    try {
      final body = {
        "userId": userId,
        "productId": productId,
        "productQuantity": quantity,
        "attributesArray": attributes,
      };

      AppLogs.log("PATCH Body: $body");

      final response = await AppApi.getInstance()
          .patch(ApiConfig.updateCart, data: body);

      AppLogs.log("Response: ${response.data}");

      return response.data["status"] == true;
    } catch (e) {
      AppLogs.log("updateProductQty ERROR: $e");
      return false;
    }
  }

  RxSet<int> updatingIndexes = <int>{}.obs;

  void increment(int index) async {
    AppLogs.log(" increment() START index: $index");
    updatingIndexes.add(index); // loader start

    final cart = cartList[index];
    final newQty = cart.productQuantity + 1;

    cartList[index] = cart.copyWith(productQuantity: newQty);
    cartList.refresh();

    bool success = await updateProductQty(
      productId: cart.productId.id,
      quantity: -1, // backend +1
      attributes: cart.attributesArray,
    );

    if (!success) {
      cartList[index] = cart;
      cartList.refresh();
    }

    updatingIndexes.remove(index);
    AppLogs.log("increment() END --------------------------");
  }

  void decrement(int index) async {
    AppLogs.log("decrement() START index: $index");
    updatingIndexes.add(index);

    final cart = cartList[index];

    if (cart.productQuantity == 1) {
      cartList.removeAt(index);
      cartList.refresh();

      await updateProductQty(
        productId: cart.productId.id,
        quantity: 1, // backend -1
        attributes: cart.attributesArray,
      );

      updatingIndexes.remove(index);
    }

    final newQty = cart.productQuantity - 1;
    cartList[index] = cart.copyWith(productQuantity: newQty);
    cartList.refresh();

    bool success = await updateProductQty(
      productId: cart.productId.id,
      quantity: 1, // backend -1
      attributes: cart.attributesArray,
    );

    if (!success) {
      cartList[index] = cart;
      cartList.refresh();
    }

    updatingIndexes.remove(index);
    AppLogs.log("decrement() END --------------------------");
  }


}
