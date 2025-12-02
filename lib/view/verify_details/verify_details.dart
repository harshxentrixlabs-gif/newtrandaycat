import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common_font.dart';
import 'package:trendycart/view/seller_account/seller_account.dart';

import '../../app_string/app_string.dart';
import '../../utils/app_color.dart';

class VerifyDetails extends StatefulWidget {
  const VerifyDetails({super.key});

  @override
  State<VerifyDetails> createState() => _VerifyDetailsState();
}

class _VerifyDetailsState extends State<VerifyDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: "Verify Details"),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.060),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: AppImage.svg(AppIcons.verifyDetails)),
              SizedBox(height: Get.height * 0.02,),
              AppText("Enter OTP",fontFamily:AppFont.bold,fontSize: 30,),
              SizedBox(height: Get.height * 0.02,),
              AppText("We Have just sent you 6 digit code via",color: Colors.grey,fontFamily: AppFont.medium,),
              SizedBox(height: Get.height * 0.003,),
              AppText("your phone +91 9989788980",color: Colors.grey,fontFamily: AppFont.medium,),
              SizedBox(height: Get.height * 0.03,),
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
                      decoration: BoxDecoration(
                        color: AppColor.textBlack,
                        border: Border.all(color: Colors.black)
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: AppText("Didn’t receive code?",color: Colors.grey,fontFamily: AppFont.medium,)),
                  SizedBox(width: 5,),
                  AppText("Resend Code",color: AppColor.primary,fontFamily: AppFont.medium,),
                ],
              ),
              SizedBox(height: Get.height * 0.05,),
              CommonBlackButton(title: "Continue",onTap: (){
                Get.to(()=>SellerAccount(),transition: Transition.rightToLeft);
              },)
            ],
          ),
        ),
      ),
    );
  }
}
