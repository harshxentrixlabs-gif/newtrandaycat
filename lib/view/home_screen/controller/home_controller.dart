
import 'package:get/get.dart';
import 'package:trendycart/utils/app_print.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart' hide ApiResponse;

import '../model/home_model.dart';

class HomeController extends GetxController {

  RxBool isLoading = false.obs;


  RxInt selectedIndex = 0.obs;

  List<String> titleList = ["Hoodies"];

  RxList<LiveSeller> liveSellerResponse = <LiveSeller>[].obs;

  Future<void> liveSellerResponseMethods() async {
    try {
      isLoading.value = true;
      final api = AppApi.getInstance();
      final response = await api.get(
        "${ApiConfig
            .liveSeller}?start=1&limit=20&userId=6916fbbbf4b6f3b0fa2d0df7",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response
          .success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        final productResponse = LiveSellerResponse.fromJson(jsonResponse);
        final List<LiveSeller> productList = productResponse.liveSeller;

        // ✅ Correct list assignment
        liveSellerResponse.value = productList;

        AppLogs.log("✅ liveSellerResponse: ${liveSellerResponse.length} items");
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("➡️ Fetch Just For You Products Finally");
    }
  }


  RxList<Product> product = <Product>[].obs;

  Future<void> productMethods() async {
    isLoading.value = true;
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig
            .reelUser}?start=1&limit=20&userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response
          .success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        // Get the reels list from API
        final reelsList = jsonResponse["reels"] as List;

        // Extract products
        List<Product> productList = [];

        for (var reel in reelsList) {
          if (reel["productId"] != null && reel["productId"].isNotEmpty) {
            for (var p in reel["productId"]) {
              productList.add(Product.fromJson(p));
            }
          }
        }

        // Assign to RxList
        product.assignAll(productList);

        AppLogs.log("✅ Product Loaded: ${product.length} items");
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("➡️ Fetch Just For You Products Finally");
    }
  }


  RxList<Reel> reel = <Reel>[].obs;

  Future<void> reelsMethods() async {
    isLoading.value = true;
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig
            .reelUser}?start=1&limit=20&userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data; // Already a Map
        AppLogs.log("JSON Response: $jsonResponse");

        // Correct Key = "reels"
        final List<dynamic> reelList = jsonResponse["reels"] ?? [];

        // Convert List to Model
        final List<Reel> reelModelList =
        reelList.map((e) => Reel.fromJson(e)).toList();

        // Update RxList
        reel.assignAll(reelModelList);

        AppLogs.log("✅ Reel List Loaded: ${reel.length} items");
      } else {
        throw Exception("Status code != 200");
      }
    } catch (e) {
      isLoading.value = false;
      AppLogs.log("❌ Error: $e");
    }
  }


  RxList<Data> data = <Data>[].obs;

  Future<void> popularProductMethods() async {
    isLoading.value = true;
    try {
      final api = AppApi.getInstance();

      final response = await api.get(ApiConfig.popularProduct);

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response
          .success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        /// Correct Parsing
        final popularProducts = PopularProducts.fromJson(jsonResponse);

        /// Extract List<Data>
        final List<Data> productList = popularProducts.data ?? [];

        /// Assign to RxList
        data.value = productList;

        AppLogs.log("✅ Popular List: ${data.length} items");
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("➡️ Fetch Popular Products Finally");
    }
  }


  RxList<JustForYouProduct> justForYouProduct = <JustForYouProduct>[].obs;

  Future<void> fetchJustForYou() async {
    isLoading.value = true;
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.justForYouProducts}?userId=691471fbf4b6f3b0fa2d0151",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        final productResponse = JustForYouProductResponse.fromJson(
            jsonResponse);
        final List<JustForYouProduct> productList = productResponse.justForYouProducts;

        // ✅ Correct list assignment
        justForYouProduct.value = productList;

        AppLogs.log("✅ Product List: ${justForYouProduct.length} items");
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("➡️ Fetch Just For You Products Finally");
    }
  }


  RxList<Product> newCollectionProduct = <Product>[].obs;
  Future<void> fetchProduct() async {
    isLoading.value = true;
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.newCollection}?userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('[ fetchProduct ] STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        /// Parse API → ApiResponse model
        final apiResponse = ApiResponse.fromJson(jsonResponse);

        /// Assign list
        newCollectionProduct.value = apiResponse.products;

        AppLogs.log(
            "✅ Product List Loaded: ${newCollectionProduct.length} items");
        update();
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("➡️ Fetch Products Finally");
    }
  }


  /// ⭐ Toggle Favorite
  void toggleFavorite(int index) async {
    final product = newCollectionProduct[index];
    AppLogs.log("$product");
    final newStatus = !product.isFavorite;
    AppLogs.log("newStatus $newStatus");

    // API call first
    bool success = await updateFavoriteOnServer(
      product.id,
      newStatus,
      product.id,
      product.category,
    );
    if (success) {
      newCollectionProduct[index] = product.copyWith(
        isFavorite: newStatus,
      );
      AppLogs.log("${newCollectionProduct[index]}");
      update();
    }
  }




  /// ⭐ Send favorite/unfavorite to backend
  Future<bool> updateFavoriteOnServer(
      String id, bool isFav, String productId, String categoryId) async {
    try {
      final api = AppApi.getInstance();

      await api.post(
        ApiConfig.favoriteUnfavorite,
        data: {
          "userId": "691aaefdf4b6f3b0fa2d1060",
          "productId": productId,
          "categoryId": categoryId,
          "isFavorite": isFav,
        },
      );

      return true; // server ok
    } catch (e) {
      AppLogs.log("Fav update error: $e");
      return false; // failed
    }
  }


}
