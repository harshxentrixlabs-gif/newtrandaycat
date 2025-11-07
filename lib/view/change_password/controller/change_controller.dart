import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeController extends GetxController{

  RxBool isOldPasswordVisible = false.obs;
  RxBool isNewConfirmPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void oldPasswordVisible() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }
  void newPasswordVisible() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void newConfirmPasswordVisible() {
    isNewConfirmPasswordVisible.value = !isNewConfirmPasswordVisible.value;
  }

  void clearText() {
    oldPasswordController.clear();
    confirmPasswordController.clear();
    newPasswordController.clear();

  }

}