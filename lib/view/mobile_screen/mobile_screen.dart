import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/utils/commons.dart';
import 'package:trendycart/view/mobile_screen/controller/mobile_controller.dart';
import 'package:trendycart/view/otp_screen/otp_screen.dart';

import '../../utils/app_print.dart';
import '../../utils/common/app_appbar.dart';
import '../../utils/common/app_bottom_sheet.dart';
import '../../utils/common/app_text.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final MobileController mobileController = Get.put(MobileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppLogs.log("mobile Screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.050,
          vertical: Get.height * 0.030,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  AppText(
                    AppString.logInWithMobile,
                    fontSize: Get.width * 0.040,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: Get.height * 0.010),
                  AppText(
                    AppString.enterYourMobileNumberToReceiveaVerificationCode,
                    fontSize: Get.width * 0.025,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.050),
            AppText(AppString.contactNumber),
            SizedBox(height: Get.height * 0.020),
            CommonTextField(
              controller: mobileController.mobileNUmberController,
              hintText: AppString.enterYourMobileNumber,
              keyboardType: TextInputType.number,
              prefixIcon: InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      mobileController.countryCode.value = '+${country.phoneCode}';
                      mobileController.countryFlag.value = country.flagEmoji;
                    },
                  );
                },
                child: Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.030),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        mobileController.countryFlag.value,
                        fontSize: Get.height * 0.015,
                      ),
                      SizedBox(width: Get.width * 0.015),
                      AppText(
                        mobileController.countryCode.value,
                        color: AppColor.textBlack,
                        fontSize: Get.height * 0.015,
                      ),
                      Icon(Icons.arrow_drop_down_rounded, color: Colors.black),
                    ],
                  ),
                )),
              ),

            ),
            Spacer(),
            CommonButton(title: AppString.sendOTP,onTap: (){
              AppLogs.log("Next otp screen");
              Get.to(() => OtpScreen(),
                transition: Transition.rightToLeft,
              );
            },),
          ],
        ),
      ),
    );
  }
}
