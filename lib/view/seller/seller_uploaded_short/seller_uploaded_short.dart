import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:trendycart/utils/common/app_appbar.dart';

import '../../add_my_address/add_my_address.dart';

class SellerUploadedShort extends StatefulWidget {
  const SellerUploadedShort({super.key});

  @override
  State<SellerUploadedShort> createState() => _SellerUploadedShortState();
}

class _SellerUploadedShortState extends State<SellerUploadedShort> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(title: "Shorts",actions: [
        Padding(
          padding: EdgeInsets.only(right:  20.0,top: 15,left: 15,),
          child: GestureDetector(
            onTap: (){
              Get.to(()=>AddMyAddress(),
                  transition: Transition.rightToLeft
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding:  EdgeInsets.all(5.0),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ),
      ],),
    );
  }
}
