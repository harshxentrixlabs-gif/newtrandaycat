import 'dart:convert';
import 'package:get/get.dart';
import '../../../../service/api_config.dart';
import '../../../../service/api_service.dart';
import '../model/seller_bank_model.dart';

class BankController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<BankData> bankList = <BankData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBankList();
  }

  Future<void> fetchBankList() async {
    try {
      isLoading.value = true;

      final api = AppApi.getInstance();
      final response = await api.get(ApiConfig.bank);

      if (response.statusCode == 200) {

        /// 🔥 FIRST: Convert String → JSON Map
        final jsonMap = response.data;

        /// 🔥 THEN: Convert Map → Model
        final data = BankResponse.fromJson(jsonMap);

        bankList.value = data.bank;
      }
    } catch (e) {
      print("Bank Fetch Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
