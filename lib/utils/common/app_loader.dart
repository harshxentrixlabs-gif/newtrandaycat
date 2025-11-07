import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_color.dart';

class AppLoaderWidget extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const AppLoaderWidget({
    Key? key,
    this.size = 40,
    this.strokeWidth = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
        ),
      ),
    );
  }
}
