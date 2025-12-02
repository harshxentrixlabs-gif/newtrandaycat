import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_color.dart';
import 'common/app_loader.dart';

class AppLoaderShow {
  static void show() {
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const AppLoaderWidget(strokeWidth: 3,
            // valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
    );
  }

  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
