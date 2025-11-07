import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_dropdown.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';

import '../../../utils/app_icons.dart';

class SellerWallet extends StatefulWidget {
  const SellerWallet({super.key});

  @override
  State<SellerWallet> createState() => _SellerWalletState();
}

class _SellerWalletState extends State<SellerWallet> {
  TextEditingController textEditingController = TextEditingController();

  var select = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: "My Wallet",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: AppImage.svg(AppIcons.withdraw),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.020),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColor.primary.withValues(alpha: 0.2)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText("Total Earning",fontSize: Get.height * 0.016,fontWeight: FontWeight.bold,color: Colors.grey,),
                        SizedBox(height: 10,),
                        AppText("\$ 500",fontSize: Get.height * 0.020,fontWeight: FontWeight.bold,),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_sharp,size: 30,)
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.015,),
            AppText("Enter Amount"),
            SizedBox(height: Get.height * 0.015,),
            CommonTextField(controller: textEditingController, hintText: "Enter withdraw amount"),
            SizedBox(height: Get.height * 0.015,),
            CommonDropdown(hint: "Select Payment Gateway", items: [], selectedValue: select.obs),
            Spacer(),
            CommonButton(title: "Withdraw")
          ],
        ),
      ),
    );
  }
}
