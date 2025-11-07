import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trendycart/utils/app_print.dart';

class ListAnItemController extends GetxController {
  var pickedImages = <File>[].obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImagesFromGallery() async {
    AppLogs.log("pickImagesFromGallery");
    AppLogs.log("[pickedImages]$pickedImages");
    AppLogs.log("[_picker]$_picker");
    final List<XFile>? images = await _picker.pickMultiImage();
    AppLogs.log("[images]$images");
    if (images != null && images.isNotEmpty) {
      if (pickedImages.length + images.length > 10) {
        AppLogs.log("[pickedImages.length]${pickedImages.length}");
        AppLogs.log("[images.length]${images.length}");
        Get.snackbar("Limit reached", "You can select up to 10 photos only");
      } else {
        pickedImages.addAll(images.map((e) => File(e.path)));
      }
    }
  }


  Future<void> takePhoto() async {
    AppLogs.log("takePhoto");
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    AppLogs.log("[image]${image}");
    if (image != null) {
      if (pickedImages.length >= 10) {
        AppLogs.log("[pickedImages.length]${pickedImages.length}");
        Get.snackbar("Limit reached", "You can select up to 10 photos only");
      } else {
        pickedImages.add(File(image.path));
      }
    }
  }


  void deletePhoto(int index) {
    pickedImages.removeAt(index);
    AppLogs.log("[pickedImages.removeAt(index);]${pickedImages.removeAt(index)}");
  }
}
