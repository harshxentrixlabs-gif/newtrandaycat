import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../../../service/api_config.dart';
import '../../../utils/app_storage.dart';
import '../../navigation_menu/navigation_menu.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  final box = GetStorage();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginModel? userLogin;

  // ----------------------------------------------------------------------
  // ⭐ GOOGLE LOGIN + API CALL (FINAL CLEAN VERSION)
  // ----------------------------------------------------------------------
  void googleLoginAndApiCall() async {
    try {
      isLoading(true);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading(false);
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      // Extract Google User Data
      String email = user?.email ?? "";
      String name = user?.displayName ?? "";
      String image = user?.photoURL ?? "";

      // Save Google Data Locally
      box.write('userEmail', email);
      box.write('userName', name);
      box.write('userPhoto', image);

      // Split Name
      List<String> fullName = name.split(" ");
      String first = fullName.isNotEmpty ? fullName.first : "";
      String last  = fullName.length > 1 ? fullName.last : "";

      // Call API
      getLoginData(
        firstName: first,
        lastName: last,
        image: image,
        email: email,
        password: "",
        loginType: 2,
        fcmToken: "123",
        identity: "google",
      );
    } catch (e) {
      log("Google Login Error: $e");
      Get.snackbar("Error", "Google Login Failed");
    } finally {
      isLoading(false);
    }
  }

  // ----------------------------------------------------------------------
  // ⭐ CALL API
  // ----------------------------------------------------------------------
  Future<void> getLoginData({
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
        // Save Full User Data After API success
        box.write('userId', userLogin!.user?.id ?? "");
        box.write('userEmail', userLogin!.user?.email ?? "");
        box.write('userName', userLogin!.user?.firstName ?? "");
        box.write('userImage', userLogin!.user?.image ?? "");

        Get.offAll(() => NavigationMenu());
      } else {
        Get.snackbar("Login Failed", userLogin!.message ?? "Something went wrong");
      }
    } finally {
      isLoading(false);
    }
  }

  // ----------------------------------------------------------------------
  // ⭐ API METHOD
  // ----------------------------------------------------------------------
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
    final url = Uri.parse(ApiConfig.userLogin);

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

    log("API RESPONSE: ${response.body}");

    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Login Failed");
    }
  }

  // ----------------------------------------------------------------------
  // ⭐ LOGOUT
  // ----------------------------------------------------------------------
  Future<void> logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    AppStorage().clear();
  }
}
