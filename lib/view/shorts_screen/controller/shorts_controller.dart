import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:trendycart/utils/app_print.dart';

class ShortsController extends GetxController {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://cdn.pixabay.com/video/2025/07/01/288891_tiny.mp4',
    'https://cdn.pixabay.com/video/2021/04/19/71563-538962838_tiny.mp4',
    'https://cdn.pixabay.com/video/2024/06/07/215757_tiny.mp4',
    'https://cdn.pixabay.com/video/2022/10/17/135333-761273772_tiny.mp4',
    'https://cdn.pixabay.com/video/2023/02/16/150888-799711541_tiny.mp4',
    'https://cdn.pixabay.com/video/2023/10/18/185564-875823704_tiny.mp4',
    'https://cdn.pixabay.com/video/2022/10/19/135587-762107320_large.mp4',

  ];

  RxInt currentIndex = 0.obs;
  late VideoPlayerController videoController;


  @override
  void onInit() {
    super.onInit();
     _initializeVideo(videoUrls[0]);
  }

  void _initializeVideo(String url) {
    Uri urll = Uri.parse(url);
    videoController = VideoPlayerController.networkUrl(urll)
       ..initialize().then((_) {
        videoController.play();
        videoController.setLooping(true);
        update();
      });
    AppLogs.log("Video initialized with URL: $url");
  }

  Future<void> onPageChanged(int index) async {
    AppLogs.log("onPageChanged");
    currentIndex.value = index;
    AppLogs.log("Switched to video index: $index");
    AppLogs.log(" currentIndex.value: ${ currentIndex.value}");

    await videoController.pause();
    await videoController.dispose();

    _initializeVideo(videoUrls[index]);
  }

  void togglePlayPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    update();
  }

}
