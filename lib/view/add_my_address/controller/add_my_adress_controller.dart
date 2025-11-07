import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMyAddressController extends GetxController {
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController zipCodeEditingController = TextEditingController();
  TextEditingController addressNameEditingController = TextEditingController();

  var selectedCountry = ''.obs;
  var selectedState = ''.obs;
  var selectedCity = ''.obs;
}
