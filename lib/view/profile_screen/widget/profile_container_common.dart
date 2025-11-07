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
            color:  AppColor.primary.withValues(alpha: 0.25),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: AppImage.svg(images,height: 25,color: Colors.white),
                  )),
              SizedBox(width: Get.width * 0.020,),
              AppText(title,color: AppColor.textBlack,fontWeight: FontWeight.bold,),
              Spacer(),
              Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,)
            ],
          ),
        ),
      ),
    );
  }
}
