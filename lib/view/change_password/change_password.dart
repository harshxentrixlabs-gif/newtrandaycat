import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/change_password/controller/change_controller.dart';

import '../../app_string/app_string.dart';
import '../../utils/common/app_textfield.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final ChangeController changeController = Get.put(ChangeController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.changePassword),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.030,
          vertical: Get.height * 0.020,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  AppString.theNewPasswordMustEDifferentBeFromTheCurrentPassword,
                  fontSize: Get.height * 0.012,
                  color: Colors.grey,
                ),
                SizedBox(height: Get.height * 0.080),
                AppText(AppString.oldPassword, fontSize: Get.height * 0.012),
                SizedBox(height: Get.height * 0.010),
                Obx(
                  () => CommonTextField(
                    controller: changeController.oldPasswordController,
                    hintText: AppString.oldPassword,
                    obscureText: changeController.isOldPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.oldPassword;
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        changeController.isOldPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        changeController.oldPasswordVisible();
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.050),
                Divider(color: Colors.black),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.newPassword, fontSize: Get.height * 0.012),
                SizedBox(height: Get.height * 0.010),
                Obx(
                  () => CommonTextField(
                    controller: changeController.newPasswordController,
                    hintText: AppString.newPassword,
                    obscureText: changeController.isNewPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.newPassword;
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        changeController.isNewPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        changeController.newPasswordVisible();
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.confirmPassword, fontSize: Get.height * 0.012),
                SizedBox(height: Get.height * 0.010),
                Obx(
                  () => CommonTextField(
                    controller: changeController.confirmPasswordController,
                    hintText: AppString.confirmPassword,
                    obscureText:
                        changeController.isNewConfirmPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.confirmPassword;
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        changeController.isNewConfirmPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        changeController.newConfirmPasswordVisible();
                      },
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.010),
                Row(
                  children: [
                    Icon(Icons.check, size: 20),
                    SizedBox(width: Get.width * 0.008),
                    Expanded(
                      child: AppText(
                        "There must be at least 8 characters",
                        fontSize: Get.height * 0.014,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.008),
                Row(
                  children: [
                    Icon(Icons.check, size: 20),
                    SizedBox(width: Get.width * 0.008),
                    Expanded(
                      child: AppText(
                        "There must be a unique code like @!#",
                        fontSize: Get.height * 0.014,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.040),
                CommonButton(
                  title: AppString.submit,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      AppLogs.log(" Continue login...");
                    } else {
                      AppLogs.log(" Validation failed");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
