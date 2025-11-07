import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/commons.dart';

import '../splash_screen/splash_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appPrint("Welcome Screen");
    Future.delayed(Duration(seconds: 3),
            (){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SplashScreen(),
              )
          );
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
