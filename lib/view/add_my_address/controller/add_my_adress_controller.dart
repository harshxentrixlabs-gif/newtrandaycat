import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../../my_address/model/address_model.dart';
import '../../my_address/controllr/address_controller.dart';
import '../model/add_model.dart';
import 'package:trendycart/utils/app_print.dart';

class AddAddressController extends GetxController {
  RxList<Country> countries = <Country>[].obs;
  RxList<String> countryNames = <String>[].obs;
  RxList<String> stateNames = <String>[].obs;
  RxList<String> cityNames = <String>[].obs;

  RxString selectedCountry = "".obs;
  RxString selectedState = "".obs;
  RxString selectedCity = "".obs;

  TextEditingController addressController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  RxBool isLoading = false.obs;

  Address? editData;

  // ---------------- INIT ----------------
  Future<void> init(Address? edit) async {
    editData = edit;

    await loadCountryData();

    if (editData != null) {
      await Future.delayed(Duration(milliseconds: 200));
      _loadEditData();
    } else {
      resetForm();
    }
  }

  // ---------------- LOAD JSON ----------------
  Future<void> loadCountryData() async {
    try {
      final jsonString = await rootBundle.loadString(
        "assets/data/country_state_city.json",
      );

      countries.value = parseCountries(jsonString);
      countryNames.value = countries.map((e) => e.name).toList();
    } catch (e) {
      AppLogs.log("❌ Country JSON Load Error: $e");
    }
  }

  // ---------------- RESET FORM ----------------
  void resetForm() {
    addressController.clear();
    zipController.clear();
    addressNameController.clear();

    selectedCountry.value = "";
    selectedState.value = "";
    selectedCity.value = "";

    stateNames.clear();
    cityNames.clear();

    editData = null;
  }

  // ---------------- LOAD EDIT DATA ----------------
  void _loadEditData() {
    addressController.text = editData?.address ?? "";
    zipController.text = editData?.zipCode.toString() ?? "";
    addressNameController.text = editData?.name ?? "";

    selectedCountry.value = editData?.country ?? "";
    selectedState.value = editData?.state ?? "";
    selectedCity.value = editData?.city ?? "";

    // Country
    final country = countries.firstWhere(
          (e) => e.name.toLowerCase().trim() ==
          selectedCountry.value.toLowerCase().trim(),
      orElse: () => countries.first,
    );

    stateNames.value = country.states.map((e) => e.name).toList();

    // State
    final state = country.states.firstWhere(
          (e) => e.name.toLowerCase().trim() ==
          selectedState.value.toLowerCase().trim(),
      orElse: () => country.states.first,
    );

    cityNames.value = state.cities.map((e) => e.name).toList();
  }

  // ---------------- UPDATE STATES ----------------
  void updateStates(String country) {
    selectedCountry.value = country;
    selectedState.value = "";
    selectedCity.value = "";

    final c = countries.firstWhere(
          (e) => e.name.toLowerCase().trim() ==
          country.toLowerCase().trim(),
    );

    stateNames.value = c.states.map((s) => s.name).toList();
    cityNames.clear();
  }

  // ---------------- UPDATE CITIES ----------------
  void updateCities(String state) {
    selectedState.value = state;
    selectedCity.value = "";

    final c = countries.firstWhere(
          (e) => e.name.toLowerCase().trim() ==
          selectedCountry.value.toLowerCase().trim(),
    );

    final s = c.states.firstWhere(
          (e) => e.name.toLowerCase().trim() ==
          state.toLowerCase().trim(),
    );

    cityNames.value = s.cities.map((e) => e.name).toList();
  }

  // ---------------- ADD ADDRESS ----------------
  Future<void> _addAddress() async {
    final api = AppApi.getInstance();

    await api.post(
      ApiConfig.sendAddress,
      data: {
        "userId": "691aaefdf4b6f3b0fa2d1060",
        "name": addressNameController.text,
        "country": selectedCountry.value,
        "state": selectedState.value,
        "city": selectedCity.value,
        "zipCode": zipController.text,
        "address": addressController.text,
      },
    );
  }

  // ---------------- UPDATE ADDRESS ----------------
  Future<void> _updateAddress() async {
    try {
      final api = AppApi.getInstance();

      final url =
          "${ApiConfig.selectOrNotAddress}?userId=${editData!.userId}&addressId=${editData!.sId}";

      final response = await api.put(
        url,
        data: {
          "name": addressNameController.text,
          "country": selectedCountry.value,
          "state": selectedState.value,
          "city": selectedCity.value,
          "zipCode": zipController.text,
          "address": addressController.text,
        },
      );

      AppLogs.log("UPDATE STATUS: ${response.statusCode}");
      AppLogs.log("UPDATE BODY: ${response.success}");
    } catch (e) {
      AppLogs.log("❌ UPDATE ERROR: $e");
    }
  }





  // ---------------- DELETE ADDRESS ----------------
  Future<void> deleteAddress({
    required String userId,
    required String addressId,
  }) async {
    final api = AppApi.getInstance();

    await api.delete(
      "${ApiConfig.deleteAddress}?userId=$userId&addressId=$addressId",
    );
  }

  // ---------------- SAVE (ADD / UPDATE) ----------------
  Future<void> saveAddress() async {
    isLoading.value = true;

    try {
      if (editData == null) {
        await _addAddress();
      } else {
        await _updateAddress();
      }

      final addressCtl = Get.find<AddressController>();
      await addressCtl.getAddress();

      Get.back();
    } catch (e) {
      AppLogs.log("❌ Save Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
