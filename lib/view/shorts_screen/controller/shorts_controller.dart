import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:video_player/video_player.dart';

class ShortsController extends GetxController {
  final List<String> videoUrls = [
    'https://cdn.pixabay.com/video/2022/07/24/125314-733046618_large.mp4',
    'https://cdn.pixabay.com/video/2021/08/13/84881-588566509_large.mp4',
  ];

  RxInt currentIndex = 0.obs;

  late VideoPlayerController videoController;

  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    _initializeVideo(videoUrls[currentIndex.value]);

  }

  void _initializeVideo(String url) {
    videoController = VideoPlayerController.network(url)
      ..initialize().then((_) {
        videoController.play();
        update();
      });
    AppLogs.log("$videoController");
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
    AppLogs.log("${currentIndex.value}");
    videoController.pause();
    videoController.dispose();

    _initializeVideo(videoUrls[index]);
  }

  void togglePlayPause() {
    AppLogs.log("togglePlayPause");
    if (videoController.value.isPlaying) {
      videoController.pause();
      AppLogs.log("${videoController.pause()}");
    } else {
      videoController.play();
      AppLogs.log("${videoController.play()}");
    }
    update();
  }

  @override
  void onClose() {
    videoController.dispose();
    pageController.dispose();
    super.onClose();
  }
}
