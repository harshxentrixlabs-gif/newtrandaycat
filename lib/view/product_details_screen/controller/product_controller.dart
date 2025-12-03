import 'dart:developer' as AppLogs;
import 'dart:ui';
import 'package:get/get.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../../../utils/app_toast.dart' show AppToast;
import '../../home_screen/model/home_model.dart';
import '../model/product_details_model.dart';

class ProductController extends GetxController {
  RxInt selectedIndex = 0.obs;

  /// Single Loading State for both operations
  RxBool isLoading = false.obs;




  RxList<ProductDetailsModel> productDetails = <ProductDetailsModel>[].obs;

  /// =================== Get Product Details ===================
  Future<void> productDetailsMethods({required String productId}) async {
    try {
      isLoading(true);
      final api = AppApi.getInstance();
      final response = await api.get(
        "https://trendybackend.codestoreapp.com/product/detail?productId=$productId&userId=691abacbf4b6f3b0fa2d10c5",
      );

      final data = response.data; // IMPORTANT ✔

      if (data["status"] == true) {
        productDetails.clear();

        List list = data["product"] ?? [];
        productDetails.addAll(
          list.map((e) => ProductDetailsModel.fromJson(e)).toList(),
        );

        AppLogs.log("PRODUCT DETAILS FETCHED: ${productDetails.length}");
      } else {
        AppToast.error("Failed to load product!");
      }
    } catch (e) {
      AppLogs.log("PRODUCT DETAILS ERROR: $e");
      AppToast.error("Something went wrong!");
    } finally {
      isLoading(false);
    }
  }

  RxList<RelatedProduct> relatedProductList = <RelatedProduct>[].obs;

  Future<void> relatedProductsMethod({
    required String productId,
    required String categoryId,
  }) async {
    try {
      isLoading(true);
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.getRelatedProductsByCategory}"
            "?userId=691aaefdf4b6f3b0fa2d1060"
            "&productId=$productId"
            "&categoryId=$categoryId",
      );

      final data = response.data;

      AppLogs.log("RELATED RESPONSE: $data");

      if (data["status"] == true) {
        relatedProductList.clear();

        /// 🔥 FIXED → Correct JSON key
        List list = data["relatedProducts"] ?? [];

        relatedProductList.addAll(
          list.map((e) => RelatedProduct.fromJson(e)).toList(),
        );

        AppLogs.log("RELATED PRODUCTS COUNT: ${relatedProductList.length}");
      } else {
        AppToast.error(data["message"] ?? "Failed to load related products!");
      }
    } catch (e) {
      AppLogs.log("RELATED PRODUCT ERROR: $e");
      AppToast.error("Something went wrong!");
    } finally {
      isLoading(false);
    }
  }

  /// =================== Add To Cart ===================
  Future<void> addProduct({required String productId}) async {
    if (isLoading.value) return;

    try {
      isLoading(true);
      final api = AppApi.getInstance();

      final body = {
        "userId": "691aaefdf4b6f3b0fa2d1060",
        "productId": productId,
        "attributesArray": [],
        "productQuantity": 1,
      };

      AppLogs.log("ADD TO CART BODY: $body");

      final response = await api.post(ApiConfig.addToCart, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppToast.success("Product successfully added!");
      } else {
        AppToast.error("Add to cart failed!");
      }

      AppLogs.log("ADD TO CART SUCCESS: ${response.data}");
    } catch (e) {
      AppLogs.log("ADD TO CART ERROR: $e");
      AppToast.error("Something went wrong!");
    } finally {
      isLoading(false);
      update();
    }
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


  Future<void> toggleFavoriteProduct(String productId) async {
    if (isLoading.value) return; // Prevent fast double-clicks

    isLoading(true);

    int mainIndex = productDetails.indexWhere((e) => e.id == productId);
    int relatedIndex = relatedProductList.indexWhere((e) => e.id == productId);

    if (mainIndex == -1 && relatedIndex == -1) {
      isLoading(false);
      return;
    }

    bool oldStatus = mainIndex != -1
        ? productDetails[mainIndex].isFavorite
        : relatedProductList[relatedIndex].isFavorite;

    bool newStatus = !oldStatus;

    if (mainIndex != -1) {
      productDetails[mainIndex] =
          productDetails[mainIndex].copyWith(isFavorite: newStatus);
      productDetails.refresh();
    }

    if (relatedIndex != -1) {
      relatedProductList[relatedIndex] =
          relatedProductList[relatedIndex].copyWith(isFavorite: newStatus);
      relatedProductList.refresh();
    }

    bool apiResult = await updateFavoriteOnServer(productId, newStatus);

    if (!apiResult) {
      /// Rollback
      if (mainIndex != -1) {
        productDetails[mainIndex] =
            productDetails[mainIndex].copyWith(isFavorite: oldStatus);
        productDetails.refresh();
      }

      if (relatedIndex != -1) {
        relatedProductList[relatedIndex] =
            relatedProductList[relatedIndex].copyWith(isFavorite: oldStatus);
        relatedProductList.refresh();
      }
    }

    isLoading(false);
  }


}
