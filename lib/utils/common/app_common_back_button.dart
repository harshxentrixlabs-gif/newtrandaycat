import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_color.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: AppColor.textBlack),
      onPressed: () => Navigator.pop(context),
    );
  }
}

// Widget backButton({VoidCallback? onTap, double? marginLeft, double? marginTop, double? marginBottom, double? marginRight,double? height, double? width}) {
//   return GestureDetector(onTap: () {
//     Get.back();
//     if(onTap != null)onTap();
//   },
//     child: Container(
//       height: 32,width: 32,
//       margin: EdgeInsets.only(left: marginLeft ?? 16, top: marginTop ?? 5, bottom: marginBottom ?? 10,right: marginRight ?? 0),
//       decoration: BoxDecoration(
//         color: AppColor.white,
//         borderRadius: BorderRadius.circular(12),
//        border: Border.all(color: AppColor.black)
//       ),
//       child: Icon(Icons.arrow_back_ios_new, size: 18,color: AppColor.black,),
//     ),
//   );
// }