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

   List<String> titleList = ["Hoodies"];

  RxList<LiveSeller> liveSellerResponse = <LiveSeller>[].obs;

  Future<void> liveSellerResponseMethods() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.liveSeller}?start=1&limit=20&userId=6916fbbbf4b6f3b0fa2d0df7",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

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
      AppLogs.log("➡️ Fetch Just For You Products Finally");
    }
  }




  RxList<Product> product = <Product>[].obs;

  Future<void> productMethods() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.reelUser}?start=1&limit=20&userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

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
      AppLogs.log("➡️ Fetch Just For You Products Finally");
    }
  }








  RxList<Reel> reel = <Reel>[].obs;

  Future<void> reelsMethods() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.reelUser}?start=1&limit=20&userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;   // Already a Map
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
      AppLogs.log("❌ Error: $e");
    }
  }







  RxList<Data> data = <Data>[].obs;

  Future<void> popularProductMethods() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(ApiConfig.popularProduct);

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

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
      AppLogs.log("➡️ Fetch Popular Products Finally");
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

  RxList<Product> newCollectionProduct = <Product>[].obs;

  get liveSellerList => null;

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
