import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/common/app_text.dart';

class BecomeController extends GetxController {
  TextEditingController nameController = TextEditingController();

  TextEditingController mobileNUmberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxString countryCode = '+91'.obs;
  RxString countryFlag = '🇮🇳'.obs;
  var selectedOption = ''.obs;

  void setSelectedOption(String? value) {
    if (value != null) {
      selectedOption.value = value;
    }
  }
  void clearText() {
    nameController.clear();
    mobileNUmberController.clear();
    emailController.clear();
  }




}
