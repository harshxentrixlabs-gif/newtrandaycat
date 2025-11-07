import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common/app_textfield.dart';
import 'package:trendycart/view/add_my_address/controller/add_my_adress_controller.dart';

import '../../utils/common/app_dropdown.dart';

class AddMyAddress extends StatefulWidget {
  const AddMyAddress({super.key});

  @override
  State<AddMyAddress> createState() => _AddMyAddressState();
}

class _AddMyAddressState extends State<AddMyAddress> {
  final AddMyAddressController addMyAddressController = Get.put(
    AddMyAddressController(),
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: AppString.addMyAddress),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050,
            vertical: Get.height * 0.020,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(AppString.address),
                SizedBox(height: Get.height * 0.010),
                CommonTextField(
                  controller: addMyAddressController.addressEditingController,
                  hintText: AppString.enterYourAddress,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppString.pleaseEnterYourAddress;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.country),
                SizedBox(height: Get.height * 0.004),
                Obx(
                  () => CommonDropdown(
                    hint: AppString.selectCountry,
                    items: ['India', 'USA', 'UK', 'Canada'],
                    selectedValue:
                        addMyAddressController.selectedCountry.value.obs,
                  ),
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.state),
                SizedBox(height: Get.height * 0.004),
                Obx(
                  () => CommonDropdown(
                    hint: AppString.selectState,
                    items: ['Gujarat', 'Maharashtra', 'Delhi', 'Karnataka'],
                    selectedValue:
                        addMyAddressController.selectedState.value.obs,
                  ),
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.city),
                SizedBox(height: Get.height * 0.004),
                Obx(
                  () => CommonDropdown(
                    hint: AppString.selectCity,
                    items: ['Ahmedabad', 'Mumbai', 'Delhi', 'Bangalore'],
                    selectedValue:
                        addMyAddressController.selectedCity.value.obs,
                  ),
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.zipCode),
                SizedBox(height: Get.height * 0.010),
                CommonTextField(
                  controller: addMyAddressController.zipCodeEditingController,
                  hintText: AppString.enterZipCode,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppString.pleaseEnterZipCode;
                    } else if (value.length < 5) {
                      return AppString.invalidZipCode;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.020),
                AppText(AppString.addressName),
                SizedBox(height: Get.height * 0.010),
                CommonTextField(
                  controller:
                      addMyAddressController.addressNameEditingController,
                  hintText: AppString.homeOfficeCompany,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppString.pleaseEnterYourAddress;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Get.height * 0.050),
                CommonButton(
                  title: AppString.saveAddress,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (addMyAddressController
                              .selectedCountry
                              .value
                              .isEmpty ||
                          addMyAddressController.selectedState.value.isEmpty ||
                          addMyAddressController.selectedCity.value.isEmpty) {}
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
