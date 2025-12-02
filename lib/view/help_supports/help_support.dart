import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../utils/app_color.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common_font.dart';

class HelpSupport extends StatefulWidget {
  const HelpSupport({super.key});

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.helpAndSupport),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTileCard(
              title: AppText(
                "Order & Delivery Info",
                fontSize: 16,
                fontFamily: AppFont.bold,
                color: AppColor.textBlack,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText(
                    "Please do not share your password or OTP with anyone...",
                    fontSize: 14,
                      fontFamily: AppFont.semiBold
                  ),
                ),
              ],
            ),
            Divider(color: Colors.black,),
            SizedBox(height: 20),
            ExpansionTileCard(
              title: AppText(
                "App Usage Tips",
                fontSize: 16,
                fontFamily: AppFont.bold,
                color: AppColor.textBlack,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText(
                    "All payments are processed through trusted, encrypted gateways to ensure your financial data remains protected.",
                    fontSize: 14,
                    fontFamily: AppFont.semiBold,
                    color: AppColor.textBlack,
                  ),
                ),
              ],
            ),
            Divider(color: Colors.black,),
            SizedBox(height: 20),

            ExpansionTileCard(
              title: AppText(
                "Terms & Delivery Info",
                fontSize: 16,
                fontFamily: AppFont.bold,
                color: AppColor.textBlack,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText(
                    "We may update our Security Policy from time to time. Please review this page periodically for the latest version.",
                    fontSize: 14,
                    color: AppColor.textBlack,
                    fontFamily: AppFont.semiBold,

                  ),
                ),
              ],
            ),
            Divider(color: Colors.black,),

          ],
        ),
      ),
    );
  }
}
