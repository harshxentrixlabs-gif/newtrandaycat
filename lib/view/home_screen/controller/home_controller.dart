import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http show get;
import 'package:trendycart/utils/app_print.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart' hide ApiResponse;
import '../model/home_model.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;

  RxList<LiveSeller> liveSellerList = <LiveSeller>[].obs;

  Future<void> fetchLiveSellerList() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        ApiConfig.liveSeller,
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data; // ✅ No json.decode
        AppLogs.log("data $jsonResponse");

        List data = jsonResponse['data'];
        AppLogs.log("data $data");

        liveSellerList.value = data.map((e) => LiveSeller.fromJson(e)).toList();
        AppLogs.log("liveSellerList.value ${liveSellerList.value}");
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("Error: $e");
    } finally {
      AppLogs.log("Get Live Seller List Finally");
    }
  }


  RxList<Reel> reelsResponse = <Reel>[].obs;


  Future<void> fetchReels() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
          "${ApiConfig.reelUser}?start=10&limit=20&userId=691471fbf4b6f3b0fa2d0151",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        // ✅ Use the correct key from your API response
        List<dynamic> reelsData = jsonResponse['reels'] ?? [];

        // ✅ Convert list into model list
        List<Reel> reelList = reelsData.map((e) => Reel.fromJson(e)).toList();

        // ✅ Store in observable/list variable
        liveSellerList.value = reelList.cast<LiveSeller>();

        AppLogs.log("✅ Reel List: ${liveSellerList.value}");
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      AppLogs.log("➡️ Fetch Reels Finally");
    }
  }

  RxList<JustForYouProduct> justForYouProduct = <JustForYouProduct>[].obs;

  Future<void> fetchJustForYou() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.justForYouProducts}?userId=691471fbf4b6f3b0fa2d0151",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        final productResponse = JustForYouProductResponse.fromJson(jsonResponse);
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
      AppLogs.log("➡️ Fetch Just For You Products Finally");
    }
  }




  void like(Product product) {
    int index = newCollectionProduct.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      final updated = product.copyWith(
        isFavorite: !product.isFavorite,
      );

      newCollectionProduct[index] = updated;
      newCollectionProduct.refresh();

      /// API Call
      toggleLikeOnServer(updated.id, updated.isFavorite);
    }
  }



  Future<void> toggleLikeOnServer(String productId, bool isFav) async {
    try {
      final api = AppApi.getInstance();
      final response = await api.get(
        "${ApiConfig.newCollection}?userId=691471fbf4b6f3b0fa2d0151",
      );
      AppLogs.log("❤️ Like API Response: ${response.data}");
    } catch (e) {
      AppLogs.log("❌ Like API Error: $e");
    }
  }




  RxList<Product> newCollectionProduct = <Product>[].obs;

  Future<void> fetchProduct() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.newCollection}?userId=691471fbf4b6f3b0fa2d0151",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {

        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        /// Parse API → ApiResponse model
        final apiResponse = ApiResponse.fromJson(jsonResponse);

        /// Assign list
        newCollectionProduct.value = apiResponse.products;

        AppLogs.log("✅ Product List Loaded: ${newCollectionProduct.length} items");
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
