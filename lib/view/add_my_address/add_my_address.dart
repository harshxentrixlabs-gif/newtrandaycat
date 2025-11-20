import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


    return Scaffold(
      appBar: AppAppBar(title: widget.editData == null ? AppString.addMyAddress :"Edite Address"),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              AppText("Address"),
              CommonTextField(
                controller: controller.addressController,
                hintText: "Enter your address",
                maxLines: 3,
              ),

              const SizedBox(height: 15),

              AppText("Country"),
              CommonDropdown(
                hint: "Select Country",
                items: controller.countryNames,
                selectedValue: controller.selectedCountry.value,
                onChanged: (v) => controller.updateStates(v!),
              ),

              const SizedBox(height: 15),

              AppText("State"),
              CommonDropdown(
                hint: "Select State",
                items: controller.stateNames,
                selectedValue: controller.selectedState.value,
                onChanged: (v) => controller.updateCities(v!),
              ),

              const SizedBox(height: 15),

              AppText("City"),
              CommonDropdown(
                hint: "Select City",
                items: controller.cityNames,
                selectedValue: controller.selectedCity.value,
                onChanged: (v) => controller.selectedCity.value = v!,
              ),

              const SizedBox(height: 20),

              AppText("Zip Code"),
              CommonTextField(
                controller: controller.zipController,
                hintText: "Enter zip code",
              ),

              const SizedBox(height: 20),

              AppText("Address Name"),
              CommonTextField(
                controller: controller.addressNameController,
                hintText: "Home / Office / Company",
              ),

              const SizedBox(height: 30),

              CommonButton(
                title: controller.isLoading.value
                    ? "Saving..."
                    : widget.editData == null ? "Submit" :"Update Address",
                onTap: controller.isLoading.value
                    ? null
                    : () => controller.saveAddress(),
              )
            ],
          ),
        );
      }),
    );
  }
}
