import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController{



  RxInt currentPage = 0.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  RxBool isNewConfirmPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;

  void newPasswordVisible() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void newConfirmPasswordVisible() {
    isNewConfirmPasswordVisible.value = !isNewConfirmPasswordVisible.value;
  }
  void clearText() {
    emailController.clear();

  }
}