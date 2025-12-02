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
import 'package:trendycart/utils/common_font.dart';
import 'package:trendycart/view/become_seller/controller/become_controller.dart';
import 'package:trendycart/view/verify_details/verify_details.dart';
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
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.sellerAccount),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
          child: CommonBlackButton(
            title: AppString.next,
            onTap: () {
              Get.to(()=>VerifyDetails(),transition: Transition.rightToLeft);
              // if (_formKey.currentState!.validate()) {
              //   appPrint("Continue login...");
              // } else {
              //   appPrint("Validation failed");
              // }
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.050,
          vertical: Get.height * 0.020,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImage.svg(
                      AppIcons.sellerProfile,
                      height: Get.height * 0.080,
                    ),
                    SizedBox(height: Get.height * 0.014),
                    AppText(
                      AppString.completeYourSellerAccount,
                      fontSize: Get.height * 0.022,
                      fontFamily: AppFont.medium,
                      color: AppColor.textBlack,
                    ),
                    SizedBox(height: Get.height * 0.005),
                    AppText(
                      AppString.completeYourSellerAccount,
                      fontSize: Get.height * 0.014,
                      color: Colors.grey,
                      fontFamily: AppFont.bold,
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.050),
                AppText(AppString.fullName, fontSize: Get.height * 0.012,fontFamily: AppFont.semiBold,),
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
                AppText(AppString.contactNumber, fontSize: Get.height * 0.012,fontFamily: AppFont.semiBold,),
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
                AppText(AppString.email, fontSize: Get.height * 0.012,fontFamily: AppFont.semiBold,),
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
                AppText("Business Type", fontSize: Get.height * 0.012,fontFamily: AppFont.semiBold,),
                SizedBox(height: Get.height * 0.010),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Flexible(
                        child: Row(
                          children: [
                            AppRadioButton<String>(
                              value: 'option1',
                              groupValue: becomeController.selectedOption.value,
                              onChanged: (value) {
                                becomeController.selectedOption(value);
                              },
                            ),
                            Flexible(
                              child: AppText(
                                "Individual Seller",
                                fontFamily: AppFont.semiBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () => Flexible(
                        child: Row(
                          children: [
                            AppRadioButton<String>(
                              value: 'option2',
                              groupValue: becomeController.selectedOption.value,
                              onChanged: (value) {
                                becomeController.selectedOption(value);
                              },
                            ),
                            Flexible(child: AppText("Company", overflow: TextOverflow.ellipsis,fontFamily: AppFont.semiBold,)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
