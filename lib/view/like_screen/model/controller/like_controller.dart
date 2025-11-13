import 'dart:developer' as AppLogs;
import 'package:get/get.dart';
import '../../../../service/api_config.dart';
import '../../../../service/api_service.dart';
import '../like_model.dart';

class FavoriteController extends GetxController {
  RxList<FavoriteProduct> favoriteProducts = <FavoriteProduct>[].obs;



  // GET FAVORITES LIST
  Future<void> fetchFavoriteProducts() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.favorite}?userId=691471fbf4b6f3b0fa2d0151",
      );

      AppLogs.log("FAV LIST RESPONSE: ${response.data}");

      if (response.statusCode == 200 && response.data is Map) {
        final resp = FavoriteResponse.fromJson(response.data);
        favoriteProducts.value = resp.favorite;
      }
    } catch (e) {
      AppLogs.log("❌ LIST ERROR: $e");
    }
  }

  // LIKE/UNLIKE TOGGLE
  // LIKE/UNLIKE TOGGLE
  Future<void> toggleFavorite(String productId) async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.favorite}?userId=691471fbf4b6f3b0fa2d0151&productId=$productId",
      );

      AppLogs.log("❤️ TOGGLE RESPONSE: ${response.data}");

      if (response.statusCode == 200) {

        // --- LOCAL UPDATE UI FAST ---
        if (isFavorite(productId)) {
          // remove from list
          favoriteProducts.removeWhere((item) => item.productId == productId);
        } else {
          // add new favorite (API return ma product aave to add karo)
          fetchFavoriteProducts(); // fallback
        }

        // Force UI refresh
        favoriteProducts.refresh();
      }
    } catch (e) {
      AppLogs.log("❌ TOGGLE ERROR: $e");
    }
  }


  // CHECK IF PRODUCT IS ALREADY IN WISHLIST
  bool isFavorite(String productId) {
    return favoriteProducts.any((item) => item.productId == productId);
  }
}
