// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart' as vp;
//
// import 'app_image.dart';
//
//
// class CustomVideoPlayerController extends GetxController {
//   late vp.VideoPlayerController _controller;
//   RxBool isPlaying = false.obs;
//   RxBool isShowControls = true.obs;
//   RxBool isLoading = true.obs;
//   RxBool hasError = false.obs;
//   RxString errorMessage = ''.obs;
//   RxDouble progress = 0.0.obs;
//   RxString currentTime = '00:00'.obs;
//   RxString totalTime = '00:00'.obs;
//   RxBool isFullscreen = false.obs;
//
//   Timer? _hideControlsTimer;
//   Timer? _progressTimer;
//   Function(Duration current, Duration total, bool isFullScreen)? onChange;
//   String videoUrl;
//   bool seekVideoEnabled;
//   CustomVideoPlayerController({this.onChange,this.videoUrl = '',this.seekVideoEnabled = true});
//
//   @override
//   void onInit() {
//     super.onInit();
//     initializePlayer();
//   }
//
//   void initializePlayer() async {
//     try {
//       isLoading.value = true;
//       hasError.value = false;
//
//       _controller = vp.VideoPlayerController.networkUrl(
//        Uri.parse(videoUrl),
//         videoPlayerOptions: vp.VideoPlayerOptions(
//           mixWithOthers: true,
//           allowBackgroundPlayback: false,
//         ),
//       );
//
//       await _controller.initialize();
//
//       // Set up listeners
//       _controller.addListener(_videoListener);
//
//       isLoading.value = false;
//       totalTime.value = _formatDuration(_controller.value.duration);
//
//       _startProgressTimer();
//       _startHideControlsTimer();
//
//     } catch (e) {
//       hasError.value = true;
//       errorMessage.value = 'Failed to load video: ${e.toString()}';
//       isLoading.value = false;
//     }
//   }
//
//   void _videoListener() {
//     if (_controller.value.hasError) {
//       hasError.value = true;
//       errorMessage.value = _controller.value.errorDescription ?? 'Unknown error';
//       return;
//     }
//
//     isPlaying.value = _controller.value.isPlaying;
//
//     if (_controller.value.duration.inMilliseconds > 0) {
//       progress.value = _controller.value.position.inMilliseconds /
//           _controller.value.duration.inMilliseconds;
//       currentTime.value = _formatDuration(_controller.value.position);
//
//       // 🔥 Fire callback
//       onChange?.call(
//         _controller.value.position,
//         _controller.value.duration,
//         isFullscreen.value,
//       );
//     }
//   }
//
//   void _startProgressTimer() {
//     _progressTimer?.cancel();
//     _progressTimer = Timer.periodic(Duration(milliseconds: 200), (timer) {
//       if (_controller.value.isInitialized && _controller.value.isPlaying) {
//         if (_controller.value.duration.inMilliseconds > 0) {
//           progress.value = _controller.value.position.inMilliseconds /
//               _controller.value.duration.inMilliseconds;
//           currentTime.value = _formatDuration(_controller.value.position);
//         }
//       }
//       if (_controller.value.isInitialized) {
//         onChange?.call(
//           _controller.value.position,
//           _controller.value.duration,
//           isFullscreen.value,
//         );
//       }
//     });
//   }
//
//   void _startHideControlsTimer() {
//     _hideControlsTimer?.cancel();
//     _hideControlsTimer = Timer(Duration(seconds: 5), () {
//       if (isShowControls.value) {
//         hideControls();
//       }
//     });
//   }
//
//   void _resetHideControlsTimer() {
//     if (isShowControls.value) {
//       _startHideControlsTimer();
//     }
//   }
//
//   void togglePlayPause() {
//     if (_controller.value.isPlaying) {
//       _controller.pause();
//     } else {
//       _controller.play();
//     }
//     _resetHideControlsTimer();
//   }
//
//   void toggleControls() {
//     if (isShowControls.value) {
//       hideControls();
//     } else {
//       isShowControls.value = true;
//       _startHideControlsTimer();
//     }
//   }
//
//   void showControls() {
//     isShowControls.value = true;
//     _startHideControlsTimer();
//   }
//
//   void hideControls() {
//     isShowControls.value = false;
//     _hideControlsTimer?.cancel();
//   }
//
//   void seekTo(double value) {
//     if(seekVideoEnabled == false) {
//       return;
//     }
//     final duration = _controller.value.duration;
//     final position = duration * value;
//     _controller.seekTo(position);
//     _resetHideControlsTimer();
//   }
//
//   void seekForward() {
//     if(seekVideoEnabled == false) {
//       return;
//     }
//     final currentPosition = _controller.value.position;
//     final newPosition = currentPosition + Duration(seconds: 10);
//     final maxPosition = _controller.value.duration;
//
//     if (newPosition < maxPosition) {
//       _controller.seekTo(newPosition);
//     } else {
//       _controller.seekTo(maxPosition);
//     }
//     _resetHideControlsTimer();
//   }
//
//   void seekBackward() {
//     if(seekVideoEnabled == false) {
//       return;
//     }
//     final currentPosition = _controller.value.position;
//     final newPosition = currentPosition - Duration(seconds: 10);
//
//     if (newPosition > Duration.zero) {
//       _controller.seekTo(newPosition);
//     } else {
//       _controller.seekTo(Duration.zero);
//     }
//     _resetHideControlsTimer();
//   }
//
//   changeNext() {
//     // Implement logic to change to the next video
//     // This could be a list of videos or a stream
//     // For now, just print a message
//     print('Change to next video');
//   }
//
//   changePrevious() {
//     // Implement logic to change to the previous video
//     // This could be a list of videos or a stream
//     // For now, just print a message
//     print('Change to previous video');
//   }
//
//   void toggleFullscreen() {
//     isFullscreen.value = !isFullscreen.value;
//
//     if (isFullscreen.value) {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//     } else {
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]);
//     }
//
//     _resetHideControlsTimer();
//   }
//
//   void retry() {
//     hasError.value = false;
//     errorMessage.value = '';
//     initializePlayer();
//   }
//
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//
//     if (duration.inHours > 0) {
//       return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
//     } else {
//       return "$twoDigitMinutes:$twoDigitSeconds";
//     }
//   }
//
//   @override
//   void onClose() {
//     _hideControlsTimer?.cancel();
//     _progressTimer?.cancel();
//     _controller.removeListener(_videoListener);
//     _controller.dispose();
//     super.onClose();
//   }
// }
//
// class CustomVideoPlayer extends StatelessWidget {
//   final String videoUrl;
//   final String? thumbnailUrl;
//   final double height;
//   final bool seekVideoEnabled;
//   final Function()? onNext;
//   final Function()? onPrevious;
//   final Function(Duration current, Duration total, bool isFullScreen)? onChange;
//
//   const CustomVideoPlayer({
//     Key? key,
//     required this.videoUrl,
//     this.height = 250,
//     this.onChange,
//     this.thumbnailUrl,
//     this.onNext,
//     this.onPrevious,
//     this.seekVideoEnabled = true,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CustomVideoPlayerController(videoUrl: videoUrl,seekVideoEnabled: seekVideoEnabled,onChange: (current, total, isFullScreen) {
//       onChange!(current, total, isFullScreen);
//     },));
//
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Obx(() {
//           if (controller.hasError.value) {
//             return _buildErrorWidget(controller);
//           }
//
//           if (controller.isLoading.value) {
//             return _buildLoadingWidget();
//           }
//
//           return ClipRRect(borderRadius: BorderRadius.circular(12),child: _buildVideoPlayer(controller));
//         }),
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget(CustomVideoPlayerController controller) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error_outline,
//             color: Colors.red,
//             size: 50,
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Video Error',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 32),
//             child: Text(
//               controller.errorMessage.value,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: 14,
//               ),
//               maxLines: 2,
//             ),
//           ),
//           SizedBox(height: 24),
//           ElevatedButton.icon(
//             onPressed: controller.retry,
//             icon: Icon(Icons.refresh),
//             label: Text('Retry'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.red,
//               foregroundColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) {
//       // 👇 Thumbnail available => show image + loader
//       return Stack(
//         fit: StackFit.expand,
//         children: [
//       ClipRRect(borderRadius: BorderRadius.circular(12),
//           child: AppImage.network(
//             thumbnailUrl!,
//             fit: BoxFit.cover,enableCaching: true,
//           )),
//           ClipRRect(borderRadius: BorderRadius.circular(12),
//             child: Container(
//               color: Colors.black26, // overlay
//             ),
//           ),
//           Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 3,
//             ),
//           ),
//         ],
//       );
//     } else {
//       // 👇 Thumbnail not available => show blur bg + loader
//       return Stack(
//         fit: StackFit.expand,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               gradient: LinearGradient(
//                 colors: [Colors.black87, Colors.black54],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           Center(
//             child: CircularProgressIndicator(
//               color: Colors.white,
//               strokeWidth: 3,
//             ),
//           ),
//         ],
//       );
//     }
//   }
//
//
//   Widget _buildVideoPlayer(CustomVideoPlayerController controller) {
//     return GestureDetector(
//       onTap: controller.toggleControls,
//       child: Container(
//         color: Colors.transparent,
//         width: double.infinity,
//         height: double.infinity,
//         child: Stack(
//           children: [
//             // Video Player
//             Center(
//               child: AspectRatio(
//                 aspectRatio: controller._controller.value.aspectRatio,
//                 child: vp.VideoPlayer(controller._controller),
//               ),
//             ),
//
//             // Controls Overlay
//             Obx(() => AnimatedOpacity(
//               opacity: controller.isShowControls.value ? 1.0 : 0.0,
//               duration: Duration(milliseconds: 300),
//               child: controller.isShowControls.value
//                   ? _buildControlsOverlay(controller)
//                   : SizedBox.shrink(),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildControlsOverlay(CustomVideoPlayerController controller) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.black54,
//             Colors.transparent,
//             Colors.transparent,
//             Colors.black54,
//           ],
//           stops: [0.0, 0.3, 0.7, 1.0],
//         ),
//       ),
//       child: Column(
//         children: [
//           // Top Controls
//           // _buildTopControls(controller),
//           SizedBox(height: 70,),
//
//           // Center Controls
//           Expanded(
//             child: _buildCenterControls(controller),
//           ),
//
//           // Bottom Controls
//           _buildBottomControls(controller),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCenterControls(CustomVideoPlayerController controller) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         // Seek Backward
//         // _buildControlButton(
//         //   icon: Icons.replay_10,
//         //   onTap: controller.seekBackward,
//         // ),
//         _buildControlButton(
//           icon: Icons.skip_previous,
//           onTap: onPrevious ?? (){
//
//           },
//         ),
//
//         // Play/Pause
//         Obx(() => _buildControlButton(
//           icon: controller.isPlaying.value ? Icons.pause : Icons.play_arrow_rounded,
//           onTap: controller.togglePlayPause,
//           size: 64,
//         )),
//
//         _buildControlButton(
//           icon: Icons.skip_next,
//           onTap: onNext ?? (){
//
//           },
//         ),
//
//         // Seek Forward
//         // _buildControlButton(
//         //   icon: Icons.forward_10,
//         //   onTap: controller.seekForward,
//         // ),
//       ],
//     );
//   }
//
//   Widget _buildControlButton({
//     required IconData icon,
//     required VoidCallback onTap,
//     double size = 56,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           // color: Colors.black54,
//           borderRadius: BorderRadius.circular(size / 2),
//         ),
//         child: Icon(
//           icon,
//           color: Colors.white,
//           size: size - 24,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomControls(CustomVideoPlayerController controller) {
//     return Container(
//       padding: EdgeInsets.only(right: 16,left: 16,top: 16,bottom: 10),
//       child: Column(
//         children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
//             SizedBox(),
//             GestureDetector(
//               onTap: controller.toggleFullscreen,
//               child: Container(
//                 // padding: EdgeInsets.all(3),
//                 child: Obx(() => Icon(
//                   controller.isFullscreen.value
//                       ? Icons.fullscreen_exit
//                       : Icons.fullscreen,
//                   color: Colors.white,
//                   size: 25,
//                 )),
//               ),
//             ),
//           ],),
//           // Progress Bar
//           Obx(() => SliderTheme(
//             data: SliderTheme.of(Get.context!).copyWith(
//               activeTrackColor: AppColor.yellow,
//               inactiveTrackColor: Colors.white24,
//               thumbColor: AppColor.yellow,
//               overlayColor: AppColor.yellow.withOpacity(0.2),
//               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
//               overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
//             ),
//             child: Slider(/*padding: EdgeInsets.zero,*/
//               value: controller.progress.value.clamp(0.0, 1.0),
//               onChanged: (value) {
//                 controller.seekTo(value);
//               },
//               onChangeStart: (value) {
//                 if(seekVideoEnabled) {
//                   controller._hideControlsTimer?.cancel();
//                 }
//               },
//               onChangeEnd: (value) {
//                 if(seekVideoEnabled) {
//                   controller._resetHideControlsTimer();
//                 }
//               },
//             ),
//           )),
//
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Obx(() => Text(
//                 controller.currentTime.value,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,fontWeight: FontWeight.bold
//                 ),
//               )),
//
//               Obx(() => Text(
//                 controller.totalTime.value,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,fontWeight: FontWeight.bold
//                 ),
//               )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
