import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/commons.dart';

import '../login_screen/login_screen.dart';
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
      // User already logged in
      Get.offAll(() => NavigationMenu(),
          transition: Transition.fadeIn);
    } else {
      // User not SplashScreen in
      Get.offAll(() => SplashScreen(),
          transition: Transition.fadeIn);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appPrint("Welcome Screen");
    Future.delayed(Duration(seconds: 3),
            (){
              checkLoginStatus();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.primary,
      body: Center(
        child:  Lottie.network(
          'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json',
          height: 200,
        ),
      ),
    );
  }
}
