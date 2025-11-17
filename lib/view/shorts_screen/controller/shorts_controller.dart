import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../home_screen/controller/home_controller.dart';

class ShortsController extends GetxController {
  late VideoPlayerController videoController;
  int currentIndex = 0;

  void initVideo(String url) {
    videoController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        update();
        videoController.play();
      });
  }

  void onPageChanged(int index) {
    currentIndex = index;
    videoController.pause();
    initVideo(Get.find<HomeController>().reel[index].video);
  }

  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    update();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
