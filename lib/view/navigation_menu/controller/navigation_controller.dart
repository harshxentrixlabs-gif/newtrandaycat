import 'package:get/get.dart';

class NavigationController extends GetxController {

  var currentIndex = 0.obs;


  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Future<bool> onWillPop() async {
    if (currentIndex.value != 0) {
      currentIndex.value = 0;
      return false;
    }
    return true;
  }

}
