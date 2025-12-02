import 'dart:developer' as AppLogs;
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/utils/common_font.dart';
import 'package:trendycart/view/mobile_screen/controller/mobile_controller.dart';
import '../../utils/app_color.dart';
import '../../utils/app_icons.dart';
import '../../utils/common/app_image.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final MobileController mobileController = Get.put(MobileController());

  final box = GetStorage();
  final _formKey = GlobalKey<FormState>();

  late String userName = box.read('userName') ?? "Guest User";
  late String userEmail = box.read('userEmail') ?? "";
  late String userPhoto = box.read('userPhoto') ??
      "https://cdn-icons-png.flaticon.com/512/149/149071.png";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactNumberController =
  TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = userName;
    emailController.text = userEmail;
  }

  void onSave() {
    if (_formKey.currentState!.validate()) {
      AppLogs.log("Saved Successfully");
      box.write('userName', nameController.text);
      box.write('userEmail', emailController.text);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(title: "Edit Profile"),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050, vertical: Get.height * 0.050),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: Get.height * 0.055,
                        backgroundImage: NetworkImage(userPhoto),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -5,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.primary,
                            border:
                            Border.all(width: 1, color: Colors.white),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: AppImage.svg(AppIcons.camera),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.050),
                AppText("Full Name", fontSize: 14, fontFamily: AppFont.semiBold,),
                SizedBox(height: 6),
                CommonTextField(
                  controller: nameController,
                  hintText: "Enter Your Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.030),
                AppText("Contact Number",
                    fontSize: 14, fontFamily: AppFont.semiBold,),
                SizedBox(height: 6),
                CommonTextField(
                  controller: contactNumberController,
                  keyboardType: TextInputType.number,
                  hintText: "Enter Mobile Number",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter phone number";
                    } else if (value.length < 10) {
                      return "Invalid number";
                    }
                    return null;
                  },
                  prefixIcon: InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          mobileController.countryCode.value =
                          '+${country.phoneCode}';
                          mobileController.countryFlag.value =
                              country.flagEmoji;
                        },
                      );
                    },
                    child: Obx(() => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 10),
                        AppText(mobileController.countryFlag.value,
                            fontSize: 14),
                        SizedBox(width: 6),
                        AppText(mobileController.countryCode.value,
                            color: AppColor.textBlack, fontSize: 14),
                        Icon(Icons.arrow_drop_down_rounded,
                            color: Colors.black),
                      ],
                    )),
                  ),
                ),
                SizedBox(height: Get.height * 0.030),
                AppText("Email Address",
                    fontSize: 14, fontFamily: AppFont.semiBold,),
                SizedBox(height: 6),
                CommonTextField(
                  controller: emailController,
                  hintText: "Enter Email Address",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please Enter Email';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'please Enter valid Email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: Get.height * 0.050),
                CommonBlackButton(
                    title: "SAVE CHANGES", onTap: () => onSave()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
