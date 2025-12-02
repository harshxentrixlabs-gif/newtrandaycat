import 'dart:ui' as BorderType show RRect;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/utils/common_font.dart';
import '../../app_string/app_string.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_dropdown.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_text.dart';
import '../add_my_address/controller/add_my_adress_controller.dart';

class SellerAccount extends StatefulWidget {
  const SellerAccount({super.key});

  @override
  State<SellerAccount> createState() => _SellerAccountState();
}

class _SellerAccountState extends State<SellerAccount> {
  final PageController pageController = PageController();
  int currentPage = 0;

  void goNextPage() {
    if (currentPage < 4) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      AppLogs.log("Form Completed ✔");
      // TODO: Next Screen Navigation
      // Get.toNamed("/seller-success");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPage > 0) {
          pageController.previousPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppAppBar(
          title: "Seller Account",
          onBack: () {
            if (currentPage > 0) {
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              Get.back();
            }
          },
        ),

        bottomSheet: currentPage == 4
            ? SizedBox()
            : Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: CommonBlackButton(
                  title: currentPage == 0
                      ? "NEXT"
                      : currentPage == 1
                      ? "NEXT"
                      : currentPage == 2
                      ? "NEXT"
                      : currentPage == 3
                      ? "CONTINUE"
                      : currentPage == 4
                      ? ""
                      : "FINISH",
                  onTap: goNextPage,
                ),
              ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.040,
            vertical: Get.height * 0.030,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (i) {
                     currentPage = i;
                  },
                  children: const [
                    SellerAccount1(),
                    SellerAccountStep2(),
                    SellerAccountStep3(),
                    SellerAccount4(),
                    SellerAccount5(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////
/// STEP 1 Page
////////////////////////////////////////////////////////////////////////

class SellerAccount1 extends StatefulWidget {
  const SellerAccount1({super.key});

  @override
  State<SellerAccount1> createState() => _SellerAccount1State();
}

class _SellerAccount1State extends State<SellerAccount1> {
  final controller = Get.put(AddAddressController());

  final TextEditingController businessController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage.svg(AppIcons.sellerProfile, height: Get.height * 0.080),
            SizedBox(height: 20),
            AppText(
              AppString.completeYourSellerAccount,
              fontSize: 18,
              fontFamily: AppFont.bold,
            ),
            AppText("Securely Process Your Payment", color: Colors.grey),

            SizedBox(height: 40),
            AppText("Business Address", fontFamily: AppFont.semiBold,),
            SizedBox(height: 10),
            CommonTextField(
              controller: businessController,
              hintText: "Enter Business address",
            ),

            SizedBox(height: 40),
            AppText("Landmark",fontFamily: AppFont.semiBold,),
            SizedBox(height: 10),
            CommonTextField(
              controller: landmarkController,
              hintText: "Enter Landmark",
            ),

            SizedBox(height: 40),
            AppText("Pin Code", fontFamily: AppFont.semiBold,),
            SizedBox(height: 10),
            CommonTextField(
              controller: pincodeController,
              hintText: "Enter Pin Code",
            ),

            SizedBox(height: 40),
            AppText("Country", fontFamily: AppFont.semiBold,),
            CommonDropdown(
              hint: "Select Country",
              items: controller.countryNames,
              selectedValue: controller.selectedCountry.value,
              onChanged: (v) => controller.updateStates(v),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// STEP 2 Page (Bank Details)
////////////////////////////////////////////////////////////////////////

class SellerAccountStep2 extends StatefulWidget {
  const SellerAccountStep2({super.key});

  @override
  State<SellerAccountStep2> createState() => _SellerAccountStep2State();
}

class _SellerAccountStep2State extends State<SellerAccountStep2> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController holderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage.svg(AppIcons.sellerProfile, height: Get.height * 0.080),
            SizedBox(height: 10),
            AppText(
              "Bank Account Details",
              fontSize: 18,
              fontFamily: AppFont.semiBold,
            ),
            AppText("For secure payment processing", color: Colors.grey,fontFamily: AppFont.medium),

            SizedBox(height: 40),
            AppText("Bank Name", fontFamily: AppFont.semiBold,),
            SizedBox(height: 10),
            CommonDropdown(
              hint: "Select Bank",
              items: ["BOB", "SBI", "ICIC"],
              selectedValue: "",
              onChanged: (String p1) {},
            ),
            SizedBox(height: 25),
            AppText("Account Number", fontFamily: AppFont.semiBold,),
            SizedBox(height: 10),
            CommonTextField(
              controller: holderNameController,
              hintText: "Enter account number",
            ),

            SizedBox(height: 25),
            AppText("IFSC code",fontFamily: AppFont.semiBold,),
            SizedBox(height: 10),
            CommonTextField(
              controller: accountController,
              hintText: "Enter IFSC",
            ),

            SizedBox(height: 25),
            AppText("Branch", fontFamily: AppFont.semiBold,),
            SizedBox(height: 10),
            CommonTextField(
              controller: ifscController,
              hintText: "Enter branch",
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// STEP 3 Page (Bank Details)
////////////////////////////////////////////////////////////////////////

class SellerAccountStep3 extends StatefulWidget {
  const SellerAccountStep3({super.key});

  @override
  State<SellerAccountStep3> createState() => _SellerAccountStep3State();
}

class _SellerAccountStep3State extends State<SellerAccountStep3> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController holderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppImage.svg(AppIcons.right, height: Get.height * 0.080),
                  SizedBox(height: 15),
                  AppText(
                    "Complete your Seller Account",
                    fontSize: 20,
                   fontFamily: AppFont.bold,
                  ),
                  SizedBox(height: 15),
                  AppText("Securely Process Your Payment", color: Colors.grey,fontFamily: AppFont.medium,),
                  SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          AppImage.svg(AppIcons.nullImages),
                          SizedBox(width: 10),
                          Expanded(
                            child: AppText(
                              "Please upload all required documents to proceed.",
                              color: Colors.red,
                              fontFamily: AppFont.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.030),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColor.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppImage.svg(
                      AppIcons.location,
                      height: Get.height * 0.030,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Address Proof",
                        fontSize: 16,
                       fontFamily: AppFont.medium,
                      ),
                      AppText(
                        "Upload utility bill or bank statement",
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: AppFont.medium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.020),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                dashPattern: [6, 6],
                strokeWidth: 1,
                radius: Radius.circular(15),
                color: Color(0xFFE3D4D4),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFE3D4D4).withValues(alpha: 0.2),
                ),
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    AppImage.svg(AppIcons.file, height: Get.height * 0.030),
                    SizedBox(height: 10),
                    AppText(
                      "Upload Documents",
                      fontSize: 16,
                      fontFamily: AppFont.semiBold,
                    ),
                    SizedBox(height: 10),
                    AppText(
                      "Tap to select files",
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: AppFont.medium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// STEP 4 Page (Bank Details)
////////////////////////////////////////////////////////////////////////

class SellerAccount4 extends StatefulWidget {
  const SellerAccount4({super.key});

  @override
  State<SellerAccount4> createState() => _SellerAccount4State();
}

class _SellerAccount4State extends State<SellerAccount4> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    "Terms & Condition",
                    fontSize: 20,
                    fontFamily: AppFont.bold,
                  ),
                  SizedBox(height: 10),
                  AppText("Agree to continue selling", color: Colors.grey,fontFamily: AppFont.medium),
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.010),
          AppText(
            "Terms and Condition for Era",
            fontSize: 20,
            fontFamily: AppFont.bold,
          ),
          SizedBox(height: Get.height * 0.020),
          AppText(
            "How We Use Your Information",
            fontSize: 20,
            fontFamily: AppFont.bold,
          ),
          SizedBox(height: Get.height * 0.030),
          AppText(
            "Personal Information :",
            fontSize: 20,
            fontFamily: AppFont.bold,
          ),
          SizedBox(height: 10),
          AppText(
            "We use your eamil address for account management and to communicate with you about updates or important information",
            color: Colors.grey,
            fontFamily: AppFont.medium,
          ),
          SizedBox(height: Get.height * 0.030),
          AppText(
            "Personal Information :",
            fontSize: 20,
            fontFamily: AppFont.bold,
          ),
          SizedBox(height: 10),
          AppText(
            "We use your eamil address for account management and to communicate with you about updates or important information",
            color: Colors.grey,
            fontFamily: AppFont.medium,
          ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// STEP 5 Page (Bank Details)
////////////////////////////////////////////////////////////////////////

class SellerAccount5 extends StatefulWidget {
  const SellerAccount5({super.key});

  @override
  State<SellerAccount5> createState() => _SellerAccount5State();
}

class _SellerAccount5State extends State<SellerAccount5> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppImage.svg(AppIcons.endImages),
              SizedBox(height: 30),
              AppText(
                "Registration Verifying",
                fontSize: 20,
                color: AppColor.primary,
                fontFamily: AppFont.bold,
              ),
              SizedBox(height: 15),
              AppText(
                "Submission Successful",
                fontSize: 16,
                color: Colors.grey,
                fontFamily: AppFont.semiBold,
              ),
              SizedBox(height: 25),
              AppText(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
                color: Colors.grey,
                fontFamily: AppFont.medium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
