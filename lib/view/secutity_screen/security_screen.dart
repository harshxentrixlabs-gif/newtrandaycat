import 'package:flutter/material.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../utils/app_color.dart';
import '../../utils/common/app_text.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: AppString.legalAndPolicies),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "1. Data Protection",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.textBlack,
            ),
             SizedBox(height: 8),
            AppText(
              "We take your privacy seriously. All personal information is stored securely and accessed only when necessary to provide services.",
              fontSize: 14,
              color:AppColor.textBlack,
            ),
             SizedBox(height: 20),
            AppText(
              "2. Secure Transactions",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.textBlack,
            ),
             SizedBox(height: 8),
            AppText(
              "All payments are processed through trusted, encrypted gateways to ensure your financial data remains protected.",
              fontSize: 14,
              color:AppColor.textBlack,
            ),
             SizedBox(height: 20),
            AppText(
              "3. Account Security",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.textBlack,
            ),
             SizedBox(height: 8),
            AppText(
              "Please do not share your password or OTP with anyone. We never ask for confidential information over email or calls.",
              fontSize: 14,
              color:AppColor.textBlack,
            ),
             SizedBox(height: 20),
            AppText(
              "4. Updates to Policy",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.textBlack,
            ),
             SizedBox(height: 8),
            AppText(
              "We may update our Security Policy from time to time. Please review this page periodically for the latest version.",
              fontSize: 14,
              color:AppColor.textBlack,
            ),
          ],
        ),
      ),
    );
  }
}
