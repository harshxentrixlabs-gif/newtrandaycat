import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_image.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/utils/common_font.dart';
import 'package:trendycart/view/add_my_address/add_my_address.dart';
import 'package:trendycart/view/add_my_address/controller/add_my_adress_controller.dart';
import 'package:trendycart/view/my_address/controllr/address_controller.dart';

import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_loader.dart';
import '../../utils/commons.dart';

class MyAddress extends StatefulWidget {
  const MyAddress({super.key});

  @override
  State<MyAddress> createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final AddressController addressController = Get.put(AddressController());
  final AddAddressController addAddressController = Get.put(
    AddAddressController(),
  );

  @override
  void initState() {
    addressController.getAddress();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppAppBar(
        title: AppString.myAddress,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(onPressed: () {
          Get.to(
                () => AddMyAddress(),
            transition: Transition.rightToLeft,
          );
        },child: AppImage.svg(AppIcons.addAddress),backgroundColor: Colors.black,),
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          return Center(child:  AppLoaderWidget());
        }
        return addressController.address.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImage.svg(AppIcons.addressImages),
                    SizedBox(height: 20),
                    AppText("No Data Found!", color: Colors.grey,fontFamily: AppFont.semiBold,),
                  ],
                ),
              )
            : Padding(
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
                                      color: Colors.black.withValues(
                                        alpha: 0.08,
                                      ),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          AppRadioButton(value: null, groupValue: null, onChanged: (value) {  },),
                                          AppText(data.name ?? "", color: AppColor.primary, fontSize: 16,fontFamily: AppFont.bold,),

                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: ()  {
                                          Get.to(()=>AddMyAddress(editData: data,));

                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColor.primary.withValues(alpha: 0.8),
                                            shape: BoxShape.circle,
                                          ),
                                          child: AppImage.svg(
                                            AppIcons.editProfile,
                                            height: 20,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                      SizedBox(height: 5,),
                                      AppText("Address",fontSize: 14,fontFamily: AppFont.bold,),
                                  SizedBox(height: 5,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: AppText(
                                          "${data.address}, ${data.city}, ${data.state}, ${data.country}, ${data.zipCode ?? ""}",
                                          fontSize: 14,
                                          maxLines: 2,
                                          fontFamily: AppFont.medium,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await addAddressController.deleteAddress(
                                            userId: data.userId!.sId.toString(),
                                            addressId: data.sId.toString(),
                                          );
                                          await addressController.getAddress();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withValues(alpha: 0.8),
                                            shape: BoxShape.circle,
                                          ),
                                          child: AppImage.svg(
                                            AppIcons.delete,
                                            height: 20,
                                            width: 20,
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
