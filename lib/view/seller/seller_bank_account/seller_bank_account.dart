import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trendycart/view/seller/seller_bank_account/controller/bank_controller.dart';

import '../../../utils/app_color.dart';
import '../../../utils/common/app_appbar.dart';
import '../../../utils/common/app_loader.dart';
import '../../../utils/common/app_text.dart';

class SellerBankAccount extends StatelessWidget {
  SellerBankAccount({super.key});

  final BankController controller = Get.put(BankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: "Bank List"),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: AppLoaderWidget());
        }

        if (controller.bankList.isEmpty) {
          return Center(child: Text("No Banks Found"));
        }

        return ListView.builder(
          itemCount: controller.bankList.length,
          itemBuilder: (context, index) {
            final bank = controller.bankList[index];

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.primary.withOpacity(0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    bank.name,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 8),
                  AppText("ID: ${bank.id}"),
                  AppText("ID: ${bank.createdAt}"),
                  AppText("ID: ${bank.updatedAt}"),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
