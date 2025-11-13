// ignore_for_file: library_prefixes

import 'dart:io';

import 'package:get/get.dart';

String userId = "";
String sellerId = "";
String fcmToken = "";
String identify = "";
String productId = "";
String addressId = "";
String mobileNumber = "";
//-----------------------------
var isDark = false.obs;
//------------------------------
File? imageXFile;
File? sellerImageXFile;
bool? becomeSeller;
bool? isSellerRequestSand;
bool firstTimeCheckSeller = false;

///------- Edit Profile ------------\\\

String editImage = "";
String editFirstName = "";
String editLastName = "";
String editEmail = "";
String editDateOfBirth = "";
String genderSelect = "Male";
String editLocation = "";
String uniqueID = "";

///------- Seller Edits ------------\\\

bool isDemoSeller = false;
String sellerFollower = "";
String sellerEditImage = "";
String editBusinessName = "";
String editPhoneNumber = "";
String editBusinessTag = "";
String editSellerAddress = "";
String editLandmark = "";
String editCity = "";
String editPinCode = "";
String editState = "";
String editCountry = "";
String editBankBusinessName = "";
String editBankName = "";
String editAccNumber = "";
String editIfsc = "";
String editBranch = "";

///------- Setting Api Data ------------\\\

bool? isUpdateProductRequest;
int? cancelOrderCharges;

/// ====== StripePey ======== \\\

bool stripActive = true;
// String stripPublishableKey =
//     "pk_test_51NGbPASGGRMauowkOh9zIW6CQyx3yRqfi2vaMxePIWKvj8QsVWYKSvZ6k9Y4yvvfcqr0RhKjDO4iBwYa62CHau9p00TPyH8P1n";
// String stripSecrateKey =
//     "sk_test_51NGbPASGGRMauowkRvZOMxiJJmYqZluCjYdBJAP03iZ9h19iUJmDvk4vbetbdDuKXmkyW6rANORG3LwnyYtaYLW400pH6BCp4p";
// String stripSecrateKey =
//  "sk_test_51IWywoSGE6fS01MGf7xcpOZUnrvBGg7oqzz5HSquArnaft5JWVNX860dJSWrZbP9x2SQs7huXP8Okso2Wjkhcv0i00we2AcFVx";

String stripPublishableKey =
    '';
String stripSecrateKey =
    '';

/// ====== RazorPay ======= \\\
bool razorPayActive = true;
String razorPayKey = "";
String flutterWaveId = "";
bool razorPaySwitch = false;
bool stripeSwitch = false;
bool flutterWaveSwitch = false;

/// =========== Socket Manger ==========
// IO.Socket? socket;

/// =========== Firebase Notification ==========
RxBool notificationVisit = false.obs;
// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
