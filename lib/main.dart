import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/service/language_service.dart';
import 'package:trendycart/view/navigation_menu/navigation_menu.dart';
import 'package:trendycart/view/welcome_screen/welcome_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageService().loadLanguages();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      translations: LanguageService(),
      locale: LanguageService().getInitialLocale(),
      fallbackLocale: LanguageService().getInitialLocale(),
      theme: ThemeData(
       useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WelcomeScreen(),
    );
  }
}

