import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileController extends GetxController{

  TextEditingController mobileNUmberController = TextEditingController();
  RxString countryCode = '+91'.obs;
  RxString countryFlag = '🇮🇳'.obs;



  void clearText() {
    mobileNUmberController.clear();
  }
}