import 'dart:developer' as AppLogs;

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../service/api_config.dart';
import '../../../service/api_service.dart';
import '../../home_screen/controller/home_controller.dart';
import '../../home_screen/model/home_model.dart';

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
    initVideo(Get.find<ShortsController>().reel[index].video);
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




  RxBool isLoading = false.obs;

  RxList<Reel> reel = <Reel>[].obs;

  Future<void> reelsMethods() async {
    isLoading.value = true;
    try {
      final api = AppApi.getInstance();

      final response = await api.get(
        "${ApiConfig
            .reelUser}?start=1&limit=20&userId=691aaefdf4b6f3b0fa2d1060",
      );

      AppLogs.log('STATUS CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonResponse = response.data; // Already a Map
        AppLogs.log("JSON Response: $jsonResponse");

        // Correct Key = "reels"
        final List<dynamic> reelList = jsonResponse["reels"] ?? [];

        // Convert List to Model
        final List<Reel> reelModelList =
        reelList.map((e) => Reel.fromJson(e)).toList();

        // Update RxList
        reel.assignAll(reelModelList);

        AppLogs.log("✅ Reel List Loaded: ${reel.length} items");
      } else {
        throw Exception("Status code != 200");
      }
    } catch (e) {
      isLoading.value = false;
      AppLogs.log("❌ Error: $e");
    }
  }


  void toggleLike(int index) {
    reel[index].isLike = !reel[index].isLike;   // FIXED
    reel.refresh();                             // UI update

    updateLikeApi(
      reel[index].id,
      reel[index].isLike,
    );
  }

  Future<void> updateLikeApi(String reelId, bool isLike) async {
    try {
      final api = AppApi.getInstance();

      final response = await api.post(
        ApiConfig.reelLikeOrDislikeOfReel,
        data: {
          "reelId": reelId,
          "isLike": isLike,
          "userId": "691aaefdf4b6f3b0fa2d1060"
        },
      );

      AppLogs.log("LIKE API RESPONSE: ${response.data}");
    } catch (e) {
      AppLogs.log("LIKE API ERROR: $e");
    }
  }







}
