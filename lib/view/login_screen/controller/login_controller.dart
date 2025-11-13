import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http show get, post;
import 'package:trendycart/app_string/app_string.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_button_v1.dart';
import 'package:trendycart/view/home_screen/home_screen.dart';

import '../../../service/api_config.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/common/app_text.dart';
import '../../../utils/globle_veriables.dart';
import '../../navigation_menu/navigation_menu.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  final box = GetStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void clearText() {
    emailController.clear();
  }

  /// Show Dialog Box
  void showDialog({required Function() onTap}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: SvgPicture.asset(
                  AppIcons.success,
                  color: Colors.white,
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    AppString.youHveLoggedInSuccessfully,
                    color: AppColor.textBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  AppText(
                    AppString.accessTOYou,
                    color: Colors.grey,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  CommonButton(onTap: onTap, title: AppString.continueButton),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  ///  Google Login
  Future<void> googleLogin() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false; // hide loader
        AppLogs.log("Google sign-in canceled");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      AppLogs.log("Google googleAuth: $googleAuth");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      AppLogs.log("Google credential: $credential");
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      AppLogs.log("Google user: $user");
      if (user != null) {
        AppLogs.log("Google login success: ${user.email}");
        box.write('userEmail', user.email);
        box.write('userName', user.displayName);
        box.write('userPhoto', user.photoURL);
        Get.to(() => NavigationMenu(), transition: Transition.rightToLeft);
      }
    } catch (e) {
      AppLogs.log("Google login error: $e");
      Get.snackbar("Error", "Google login failed");
    } finally {
      isLoading.value = false;
    }
  }

  /// Uer email get
  late final userEmail = box.read('userEmail');

  /// Uer Logout
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    GetStorage().erase();
    AppLogs.log("User logged out");
  }

  /// Api login Methods

  LoginModel? userLogin;

  getLoginData({
    String? image,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int loginType,
    required String fcmToken,
    required String identity,
  }) async {
    try {
      // SellerDataController sellerDataController = Get.put(SellerDataController());
      isLoading(true);
      var data = await login(
        image: image,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        loginType: loginType,
        fcmToken: fcmToken,
        identity: identity,
      );
      userLogin = data;
      if (userLogin!.status == true) {
        userId = userLogin!.user!.id.toString();
        box.write("userId", userId);
        log("user Id $userId");
        //-------------------------------------------
        editImage = userLogin!.user!.image.toString();
        editFirstName = userLogin!.user!.firstName.toString();
        editLastName = userLogin!.user!.lastName.toString();
        editEmail = userLogin!.user!.email.toString();
        editDateOfBirth = userLogin!.user!.dob.toString();
        genderSelect = userLogin!.user!.gender.toString();
        editLocation = userLogin!.user!.location.toString();
        uniqueID = userLogin!.user!.uniqueId.toString();
        if (userLogin!.user!.isSeller == true) {
          // becomeSeller = true;
          // sellerDataController.getSellerAllData();
        }
        //-------------------------------------------
        box.write("editImage", editImage);
        box.write("editFirstName", editFirstName);
        box.write("editLastName", editLastName);
        box.write("editEmail", editEmail);
        box.write("dob", editDateOfBirth);
        box.write("genderSelect", genderSelect);
        box.write("location", editLocation);
        box.write("uniqueID", uniqueID);
        update();
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<LoginModel> login({
    String? image,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required int loginType,
    required String fcmToken,
    required String identity,
  }) async {
    log("image :: $image");
    log("firstName :: $firstName");
    log("lastName :: $lastName");
    log("email :: $email");
    log("password :: $password");
    log("loginType :: $loginType");
    log("fcmToken :: $fcmToken");
    log("identity :: $identity");
    final url = Uri.parse(ApiConfig.userLogin);
    log("url ::: $url");
    final headers = {
      'key': ApiConfig.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };
    final body = jsonEncode({
      'image': image,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'loginType': loginType,
      'fcmToken': fcmToken,
      'identity': identity,
    });

    final response = await http.post(url, headers: headers, body: body);
    log(
      "Login Api Status code :- ${response.statusCode} \n Body response :- ${response.body}",
    );
    // 691471fbf4b6f3b0fa2d0151
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["status"] == true) {
        box.write("isLogin", true);
      }
      return LoginModel.fromJson(jsonResponse);
    } else {
      throw Exception('Login Failed');
    }
  }
}
