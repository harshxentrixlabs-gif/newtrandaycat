import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_common_back_button.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/otp_screen/controller/otp_controller.dart';

import '../../utils/common/app_bottom_sheet.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController otpController = Get.put(OtpController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppLogs.log("Otp Screen");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppBottomSheet.show(
        title: AppString.demoOtp,
        content: Column(
          children: [
            AppText(
              AppString.notes,
            ),
            SizedBox(height: Get.height * 0.020),
            CommonButton(
              title: AppString.ok,
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.verifyDetails),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.030,
          vertical: Get.height * 0.030,
        ),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  AppText(
                    AppString.enterOTP,
                    fontSize: Get.width * 0.040,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: Get.height * 0.010),
                  AppText(
                    AppString.weHaveJustSentYour6DigitCodeVlaYourPhone,
                    fontSize: Get.width * 0.030,
                  ),
                  AppText(
                    "+91",
                    fontWeight: FontWeight.bold,
                    fontSize: Get.width * 0.030,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.08,),
            Pinput(
              length: 6,
              enableInteractiveSelection: true,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) => value == '222222' ? null : AppString.pinIsIncorrect,
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) => debugPrint('onCompleted: $pin'),
              onChanged: (value) => debugPrint('onChanged: $value'),
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: AppColor.textBlack,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.020,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(AppString.didetnreceiveCode),
                SizedBox(width: Get.width * 0.020,),
                InkWell(
                    onTap: (){


                    },
                    child: AppText(AppString.resendCode,color: AppColor.textBlack,fontWeight: FontWeight.bold,))
              ],
            ),
            Spacer(),
            CommonButton(title: AppString.continueButtonOtp)
          ],
        ),
      ),
    );
  }
}
