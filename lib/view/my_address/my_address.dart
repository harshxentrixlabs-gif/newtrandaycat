import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/add_my_address/add_my_address.dart';
import 'package:trendycart/view/add_my_address/controller/add_my_adress_controller.dart';
import 'package:trendycart/view/my_address/controllr/address_controller.dart';

import '../../utils/common/app_button_v1.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final AddressController addressController = Get.put(AddressController());
  final AddAddressController addAddressController = Get.put(AddAddressController());

  @override
  void initState() {
    addressController.getAddress();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: AppString.myAddress,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0, top: 15, left: 15),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => AddMyAddress(),
                  transition: Transition.rightToLeft,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return addressController.address.isEmpty ? Center(child: AppText("No Data")) :Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.050,
            vertical: Get.height * 0.030,
          ),
          child: Column(
            children: [
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: addressController.address.length,
                    padding: EdgeInsets.only(right: 10, bottom: 10),
                    itemBuilder: (BuildContext context, int index) {
                      final data = addressController.address[index];
                      AppLogs.log("address List $data");
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(data.name ?? ""),
                                SizedBox(height: Get.height * 0.020),
                                Row(
                                  children: [
                                    Icon(Icons.location_on),
                                    Expanded(child: AppText("${data.address},", fontSize: 12,overflow: TextOverflow.ellipsis,)),
                                    Expanded(child: AppText("${data.city},", fontSize: 12,overflow: TextOverflow.ellipsis,)),
                                    Expanded(child: AppText("${data.state},", fontSize: 12,overflow: TextOverflow.ellipsis,)),
                                    Expanded(child: AppText("${data.country},", fontSize: 12,overflow: TextOverflow.ellipsis,)),
                                    Expanded(
                                      child: AppText(
                                        "${data.zipCode ?? ""}",
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.to(
                                                () => AddMyAddress(editData: data),
                                             transition: Transition.rightToLeft,
                                          );
                                        },
                                        child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: AppColor.primary,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AppImage.svg(
                                                  AppIcons.edit,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 10),
                                                AppText(
                                                  "Change Address",
                                                  color: AppColor.textWhite,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () async {
                                        await addAddressController.deleteAddress(
                                          userId: data.userId!.sId.toString(),
                                          addressId: data.sId.toString(),
                                        );

                                        await addressController.getAddress();
                                      },

                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withValues(
                                            alpha: 0.3,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
