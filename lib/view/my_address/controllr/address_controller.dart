import 'dart:developer' as AppLogs;

import 'package:get/get.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../model/address_model.dart';

class AddressController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Address> address = <Address>[].obs;

  @override
  void onInit() {
    getAddress();
    super.onInit();
  }

  Future<void> getAddress() async {
    isLoading.value = true;

    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig.getAddress}?userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data;

        final productResponse = AddressModel.fromJson(jsonResponse);

        address.value = productResponse.address ?? [];
      } else {
        throw Exception('Status code is not 200');
      }
    } catch (e) {
      AppLogs.log("❌ Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
