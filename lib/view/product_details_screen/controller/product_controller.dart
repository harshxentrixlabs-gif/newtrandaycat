import 'dart:developer' as AppLogs;

import 'package:get/get.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../../../utils/app_toast.dart' show AppToast;
import '../../home_screen/model/home_model.dart' hide Product;
import '../model/product_details_model.dart';


class ProductController extends GetxController{
  RxInt selectedIndex = 0.obs;


  RxList<Product> product = <Product>[].obs;

  Future<void> productDetailsMethods() async {
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.productDetails}?productId=6830116ace346af3f9fc18c5&userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode} \nRESPONSE: ${response.success}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        AppLogs.log("JSON Response: $jsonResponse");

        /// Parse JSON safely
        final popularProducts = ProductModel.fromJson(jsonResponse);

        /// Extract list
        final List<Product> productList = popularProducts.product ?? [];

        product.value = productList;

        AppLogs.log("✅ Product count: ${product.length}");
      } else {
        throw Exception('[productDetailsMethods] Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("[productDetailsMethods] ❌ Error: $e");
    } finally {
      AppLogs.log("[productDetailsMethods] ➡️ Finished");
    }
  }




  Future<void> addProduct({required String productId}) async {
    try {
      final api = AppApi.getInstance();

      final response = await api.post(
        ApiConfig.addToCart,
        data: {
          "userId": "691aaefdf4b6f3b0fa2d1060",
          "productId": productId,
          "attributesArray": [],
          "productQuantity": 1,
        },
      );
      AppToast.success("Product added to cart!");
      AppLogs.log("[addProduct] Add to cart success: $response");
    } catch (e) {
      AppLogs.log("[addProduct] Error: $e`");

    }
  }





}