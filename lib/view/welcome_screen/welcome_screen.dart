import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../utils/app_color.dart';
import '../navigation_menu/navigation_menu.dart';
import '../splash_screen/splash_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final box = GetStorage();

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final userEmail = box.read('userEmail');

    if (userEmail != null && userEmail.isNotEmpty) {
      // User is logged in
      Get.offAll(() => NavigationMenu(), transition: Transition.fadeIn);
    } else {
      // Move to splash if first time
      Get.offAll(() => SplashScreen(), transition: Transition.fadeIn);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Lottie.network(
          'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
          height: 200,
        ),
      ),
    );
  }
}
