import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/common/app_image.dart';
import '../../../utils/common/app_text.dart';

class ProfileContainerCommon extends StatelessWidget {
  const ProfileContainerCommon({super.key, required this.images, required this.title, required this.onTap});
  final String images;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: AppImage.svg(images,height: 25,),
              ),
              SizedBox(width: Get.width * 0.020,),
              AppText(title,color: AppColor.textBlack,fontWeight: FontWeight.w500,),
              Spacer(),
              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,size: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
