import 'package:get/get.dart';
import 'package:trendycart/utils/app_print.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart' hide ApiResponse;

import '../category_model/category_model.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxInt selectedIndex = 0.obs;

  RxList<LiveSeller> liveSellerResponse = <LiveSeller>[].obs;
  RxList<Data> data = <Data>[].obs;

  RxList<Category> categoryList = <Category>[].obs;
  RxList<JustForYouProduct> justForYouProduct = <JustForYouProduct>[].obs;
  RxList<RelatedProduct> relatedProductList = <RelatedProduct>[].obs;


  @override
  void onInit() {
    super.onInit();
    AppLogs.log("🔷 onInit Started");
    getCategory();
    fetchJustForYou();
    AppLogs.log("🔶 onInit Ended");
  }


  void loadDefaultCategoryProducts() {
    AppLogs.log("🔷 loadDefaultCategoryProducts STARTED");

    if (categoryList.isEmpty) {
      AppLogs.log("❌ Category list empty. Skipping default load.");
      return;
    }

    selectedIndex.value = 0;

    final defaultCategoryId = categoryList[0].id;
    final defaultProductId = justForYouProduct.isNotEmpty ? justForYouProduct[0].id : "";

    AppLogs.log("🔥 Auto Load Fashion Category");
    AppLogs.log("CategoryId: $defaultCategoryId | ProductId: $defaultProductId");

    relatedProduct(
      categoryId: defaultCategoryId,
      productId: defaultProductId,
    );

    AppLogs.log("🔶 loadDefaultCategoryProducts ENDED");
  }




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






  Future<void> getCategory() async {
    AppLogs.log("🔷 getCategory STARTED");

    isLoading.value = true;

    try {
      final api = AppApi.getInstance();
      final response = await api.get(ApiConfig.getCategory);

      AppLogs.log("[getCategory] Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final categoryResponse = CategoryResponse.fromJson(response.data);
        categoryList.value = categoryResponse.category;

        AppLogs.log("[getCategory] Loaded: ${categoryList.length} items");
        loadDefaultCategoryProducts();
      } else {
        throw Exception("Category API failed");
      }
    } catch (e) {
      AppLogs.log("[getCategory] Error 👉 $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("🔶 getCategory ENDED");
    }
  }


  Future<void> relatedProduct({
    required String categoryId,
    required String productId,
  }) async {
    AppLogs.log("🔷 relatedProduct STARTED");

    isLoading.value = true;

    try {
      final api = AppApi.getInstance();
      final response = await api.get(
        "${ApiConfig.getRelatedProductsByCategory}"
            "?userId=691aaefdf4b6f3b0fa2d1060"
            "&productId=$productId"
            "&categoryId=$categoryId",
      );

      AppLogs.log("categoryId = $categoryId");
      AppLogs.log("productId = $productId");
      AppLogs.log("[relatedProduct] Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final productResponse =
        RelatedProductsResponse.fromJson(response.data);

        relatedProductList.value = productResponse.relatedProducts;

        AppLogs.log("Related Products Loaded: ${relatedProductList.length}");
      } else {
        throw Exception("Related Product API failed");
      }
    } catch (e) {
      AppLogs.log("[relatedProduct] Error: $e");
    } finally {
      isLoading.value = false;
      AppLogs.log("🔶 relatedProduct ENDED");
    }
  }


  Future<void> fetchJustForYou() async {
    AppLogs.log("🔷 fetchJustForYou STARTED");

    try {
      final api = AppApi.getInstance();
      final response = await api.get(
        "${ApiConfig.justForYouProducts}?userId=691471fbf4b6f3b0fa2d0151",
      );

      if (response.statusCode == 200) {
        final productResponse =
        JustForYouProductResponse.fromJson(response.data);

        justForYouProduct.value = productResponse.justForYouProducts;

        AppLogs.log("Just For You Loaded: ${justForYouProduct.length} items");
      }
    } catch (e) {
      AppLogs.log("❌ Just For You Error: $e");
    }

    AppLogs.log("🔶 fetchJustForYou ENDED");
  }


  Future<void> liveSellerResponseMethods() async {
    AppLogs.log("🔷 liveSellerResponse STARTED");

    try {
      final api = AppApi.getInstance();
      final response = await api.get(
        "${ApiConfig.liveSeller}?start=1&limit=20&userId=6916fbbbf4b6f3b0fa2d0df7",
      );

      if (response.statusCode == 200) {
        liveSellerResponse.value =
            LiveSellerResponse.fromJson(response.data).liveSeller;

        AppLogs.log(
            "Live Seller Loaded: ${liveSellerResponse.length} items");
      }
    } catch (e) {
      AppLogs.log("Live Seller Error: $e");
    }

    AppLogs.log("🔶 liveSellerResponse ENDED");
  }


  void toggleFavorite(int index) async {
    AppLogs.log("🔷 toggleFavorite STARTED");

    final product = relatedProductList[index];
    final newStatus = !product.isFavorite;

    bool success =
    await updateFavoriteOnServer(product.id, newStatus);

    if (success) {
      relatedProductList[index] =
          product.copyWith(isFavorite: newStatus);
      update();

      AppLogs.log("Favorite Updated Locally");
    }

    AppLogs.log("🔶 toggleFavorite ENDED");
  }


  Future<bool> updateFavoriteOnServer(
      String? productId,
      bool isFav,
      ) async {
    AppLogs.log("🔷 updateFavoriteOnServer STARTED");
    try {
      final api = AppApi.getInstance();

      await api.post(
        ApiConfig.favoriteUnfavorite,
        data: {
          "userId": "691aaefdf4b6f3b0fa2d1060",
          "productId": productId,
          "categoryId": "691c3a0db028fbecda9c050e",
          "isFavorite": isFav,
        },
      );

      AppLogs.log("Favorite API Success");

      AppLogs.log("🔶 updateFavoriteOnServer ENDED");

      return true;
    } catch (e) {
      AppLogs.log("Favorite update error: $e");
      return false;
    }
  }




}
