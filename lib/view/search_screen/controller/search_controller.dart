import 'dart:developer' as AppLogs;
import 'package:get/get.dart';
import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../model/search_model.dart';

class SearchScreenController extends GetxController {

  RxList<Product> searchList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchGet();
  }




  Future<void> searchGet() async {
    AppLogs.log("🔷 searchGet STARTED");

    try {
      final api = AppApi.getInstance();
      final response = await api.get(ApiConfig.searchProduct);

      if (response.statusCode == 200) {
        final productResponse = SearchProductsResponse.fromJson(response.data);

        searchList.value = productResponse.products?.lastSearchedProducts ?? [];

        AppLogs.log("searchGet Loaded: ${searchList.length} items");
      }
    } catch (e) {
      AppLogs.log("❌ searchGetError: $e");
    }

    AppLogs.log("🔶 searchGet ENDED");
  }



}
