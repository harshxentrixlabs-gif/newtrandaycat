import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController{

  TextEditingController emailController = TextEditingController();
  void clearText() {
    emailController.clear();

  }
}