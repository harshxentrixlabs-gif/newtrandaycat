import 'package:get/get.dart';

class CartsController extends GetxController {


  var count = 0.obs;

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }
}
