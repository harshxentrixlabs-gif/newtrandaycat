import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/common/app_appbar.dart';
import 'package:trendycart/utils/common/app_text.dart';

class SellerMyAddress extends StatefulWidget {
  const SellerMyAddress({super.key});

  @override
  State<SellerMyAddress> createState() => _SellerMyAddressState();
}

class _SellerMyAddressState extends State<SellerMyAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: "My Address"),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.050,vertical: Get.height * 0.020),
        child: Column(
          children: [
           Container(
             width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(15)),
               color: AppColor.primary.withValues(alpha: 0.2)
             ),
             child: Padding(
               padding:  EdgeInsets.all(15.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   AppText("David Lena",fontSize: Get.height * 0.018,fontWeight: FontWeight.bold,),
                   SizedBox(height: 10,),
                   AppText("9664589908"),
                   SizedBox(height: 15,),
                   AppText("Mota Varachha,Sumeru city mall"),
                   SizedBox(height: 15,),
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                       color: Colors.red.withValues(alpha: 0.2)
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: AppText("Change Address",color: Colors.red,),
                     ),
                   )
                 ],
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
