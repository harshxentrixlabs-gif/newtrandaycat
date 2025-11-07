import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/view/become_seller/controller/become_controller.dart';
import '../../app_string/app_string.dart';
import '../../utils/commons.dart';

class BecomeSeller extends StatefulWidget {
  const BecomeSeller({super.key});

  @override
  State<BecomeSeller> createState() => _BecomeSellerState();
}

class _BecomeSellerState extends State<BecomeSeller> {
  final BecomeController becomeController = Get.put(BecomeController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.sellerAccount),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.035,
          vertical: Get.height * 0.020,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppImage.svg(
                        AppIcons.seller,
                        height: Get.height * 0.040,
                        color: AppColor.primary,
                      ),
                      SizedBox(height: Get.height * 0.014),
                      AppText(
                        AppString.completeYourSellerAccount,
                        fontSize: Get.height * 0.022,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                      SizedBox(height: Get.height * 0.005),
                      AppText(
                        AppString.completeYourSellerAccount,
                        fontSize: Get.height * 0.014,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.fullName, fontSize: Get.height * 0.012),
                SizedBox(height: Get.height * 0.010),
                CommonTextField(
                  controller: becomeController.nameController,
                  hintText: AppString.enterFullName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return  AppString.pleaseEnterName;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.contactNumber, fontSize: Get.height * 0.012),
                SizedBox(height: Get.height * 0.010),
                CommonTextField(
                  controller: becomeController.mobileNUmberController,
                  hintText: AppString.enterYourMobileNumber,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.enterYourMobileNumber;
                    }
                    return null;
                  },
                  prefixIcon: InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          becomeController.countryCode.value =
                              '+${country.phoneCode}';
                          becomeController.countryFlag.value =
                              country.flagEmoji;
                        },
                      );
                    },
                    child: Obx(
                      () => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.030,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              becomeController.countryFlag.value,
                              fontSize: Get.height * 0.015,
                            ),
                            SizedBox(width: Get.width * 0.015),
                            AppText(
                              becomeController.countryCode.value,
                              color: AppColor.textBlack,
                              fontSize: Get.height * 0.015,
                            ),
                            const Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.email, fontSize: Get.height * 0.012),
                SizedBox(height: Get.height * 0.010),
                CommonTextField(
                  controller: becomeController.emailController,
                  hintText: AppString.enterYourEmailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.pleaseEnterEmail;
                    } else if (!GetUtils.isEmail(value)) {
                      return AppString.pleaseEnterValidEmail;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.020),
                AppText("Business Type", fontSize: Get.height * 0.012),
                SizedBox(height: Get.height * 0.010),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          AppRadioButton<String>(
                            value: 'option1',
                            groupValue: becomeController.selectedOption.value,
                            onChanged: (value) {
                              becomeController.selectedOption(value);
                            },
                          ),
                          AppText(
                            "Individual Seller",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Row(
                        children: [
                          AppRadioButton<String>(
                            value: 'option2',
                            groupValue: becomeController.selectedOption.value,
                            onChanged: (value) {
                              becomeController.selectedOption(value);
                            },
                          ),
                          AppText("Company", overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.040),
                CommonButton(
                  title: AppString.next,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      appPrint("Continue login...");
                    } else {
                      appPrint("Validation failed");
                    }
                  },
                ),
                SizedBox(height: Get.height * 0.020),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
