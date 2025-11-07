import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';

import '../../../utils/app_color.dart';

class SellerBankAccount extends StatefulWidget {
  const SellerBankAccount({super.key});

  @override
  State<SellerBankAccount> createState() => _SellerBankAccountState();
}

class _SellerBankAccountState extends State<SellerBankAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: "Bank Account"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.020),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColor.primary.withValues(alpha: 0.2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText("SBI",fontSize: Get.height * 0.018,fontWeight: FontWeight.bold,),
                    SizedBox(height: 20,),
                    AppText("Account Number:",fontSize: Get.height * 0.012,),
                    AppText("15005000025895546",fontSize: Get.height * 0.014,),
                    SizedBox(height: 15,),
                    AppText("IFSC Code:",fontSize: Get.height * 0.012,),
                    AppText("SBI1234",fontSize: Get.height * 0.012,),
                    SizedBox(height: 15,),
                    AppText("Branch Name:",fontSize: Get.height * 0.012,),
                    AppText("munich",fontSize: Get.height * 0.012,),

                  ],
                ),
              ),

            ),
            Spacer(),
            CommonButton(title: "CHANGE BANK DETAILS")
          ],
        ),
      ),
    );
  }
}
