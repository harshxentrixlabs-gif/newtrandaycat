import 'dart:developer' as AppLogs;
import 'package:get/get.dart';
import '../../../../service/api_config.dart';
import '../../../../service/api_service.dart';
import '../model/like_model.dart';   // ADD your model file path

class FavoriteController extends GetxController {

  /// Observable list of favorites
  RxList<FavoriteItem> favoriteList = <FavoriteItem>[].obs;

  /// Loading states
  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;

  final String userId = "691aaefdf4b6f3b0fa2d1060"; // your user id

  // -----------------------------
  // ⭐ Fetch Favorite List
  // -----------------------------
  Future<void> fetchFavoriteList() async {
    try {
      isLoading.value = true;

      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.favoriteProduct}?userId=$userId",
      );

      AppLogs.log("FAVORITE LIST RESPONSE: ${response.data}");

      if (response.statusCode == 200) {
        final parsed = FavoriteResponse.fromJson(response.data);
        favoriteList.value = parsed.favorite;
      }
    } catch (e) {
      AppLogs.log("❌ Favorite List Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // ⭐ Add / Remove Favorite
  // Backend handles toggle automatically
  // -----------------------------
  Future<void> toggleFavorite(String productId, String categoryId) async {
    try {
      isUpdating.value = true;
      final api = AppApi.getInstance();

      final body = {
        "userId": userId,
        "productId": productId,
        "categoryId": categoryId,
      };
      AppLogs.log("➡️ SEND FAVORITE TOGGLE BODY: $body");
      final response = await api.post(
        ApiConfig.favoriteUnfavorite,
        data: body,
      );
      AppLogs.log("FAVORITE TOGGLE RESPONSE: ${response.data}");
      // Refresh list after update
      fetchFavoriteList();

    } catch (e) {
      AppLogs.log("❌ Favorite Toggle Error: $e");
    } finally {
      isUpdating.value = false;
    }
  }
}
