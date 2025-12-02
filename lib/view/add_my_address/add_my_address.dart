import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common_font.dart';

import '../../app_string/app_string.dart';
import '../../utils/common/app_appbar.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_dropdown.dart';
import '../../utils/common/app_text.dart';
import '../../utils/common/app_textfield.dart';
import '../my_address/controllr/address_controller.dart';
import '../my_address/model/address_model.dart';
import 'controller/add_my_adress_controller.dart';

class AddMyAddress extends StatefulWidget {
  final Address? editData;

  AddMyAddress({super.key, this.editData});

  @override
  State<AddMyAddress> createState() => _AddMyAddressState();
}

class _AddMyAddressState extends State<AddMyAddress> {
  final controller = Get.put(AddAddressController());

  @override
  void initState() {
    // TODO: implement initState
    controller.init(widget.editData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value:  SystemUiOverlayStyle(
        statusBarColor: Color(0xffffdabe),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppAppBar(title: widget.editData == null ? AppString.addMyAddress :"Edite Address"),
        body: Obx(() {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                AppText("Address",fontFamily: AppFont.semiBold,),
                 SizedBox(height: 5),
                CommonTextField(
                  controller: controller.addressController,
                  hintText: "Enter your address",
                  maxLines: 3,
                ),
                 SizedBox(height: 15),
                AppText("Country",fontFamily: AppFont.semiBold,),
                SizedBox(height: 5),
                CommonDropdown(
                  hint: "Select Country",
                  items: controller.countryNames,
                  selectedValue: controller.selectedCountry.value,
                  onChanged: (v) => controller.updateStates(v),
                ),
                 SizedBox(height: 15),
                AppText("State",fontFamily: AppFont.semiBold,),
                SizedBox(height: 5),
                CommonDropdown(
                  hint: "Select State",
                  items: controller.stateNames,
                  selectedValue: controller.selectedState.value,
                  onChanged: (v) => controller.updateCities(v),
                ),
                 SizedBox(height: 15),
                AppText("City",fontFamily: AppFont.semiBold,),
                SizedBox(height: 5),
                CommonDropdown(
                  hint: "Select City",
                  items: controller.cityNames,
                  selectedValue: controller.selectedCity.value,
                  onChanged: (v) => controller.selectedCity.value = v,
                ),
                 SizedBox(height: 20),
                AppText("Zip Code",fontFamily: AppFont.semiBold,),
                SizedBox(height: 5),
                CommonTextField(
                  controller: controller.zipController,
                  hintText: "Enter zip code",
                ),
                 SizedBox(height: 20),
                AppText("Address Name",fontFamily: AppFont.semiBold,),
                SizedBox(height: 5),
                CommonTextField(
                  controller: controller.addressNameController,
                  hintText: "Home / Office / Company",
                ),
                SizedBox(height: 30),
                CommonBlackButton(
                  title: controller.isLoading.value
                      ? "Saving..."
                      : widget.editData == null ? "Save Address" :"Update Address",
                  onTap: controller.isLoading.value
                      ? null
                      : () => controller.saveAddress(),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
