import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trendycart/utils/app_color.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:video_player/video_player.dart';
import '../../utils/common/app_image.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({
    super.key,
    required this.video,
    required this.name,
    required this.view,
  });

  final String video;
  final String name;
  final String view;

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  TextEditingController textEditingController = TextEditingController();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // 🔥 VIDEO from previous screen
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video),
    )
      ..initialize().then((_) {
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          _controller.value.isInitialized
              ? VideoPlayer(_controller)
              :  Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),

          // CLOSE BUTTON
          Positioned(
            top: 45,
            right: 20,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.25),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ),

          // PROFILE + NAME + WELCOME TEXT
          Positioned(
            top: 45,
            left: 20,
            child: Container(
              width: Get.width * 0.33,
              height: Get.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black.withOpacity(0.25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipOval(
                          child: Image.network(
                            "https://picsum.photos/200",
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                     SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            fontSize: Get.height * 0.013,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            "Hello Guys Welcome",
                            overflow: TextOverflow.ellipsis,
                            fontSize: Get.height * 0.010,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // VIEW COUNT + LIVE LABEL
          Positioned(
            top: 45,
            left: 220,
            child: Container(
              width: Get.width * 0.27,
              height: Get.height * 0.04,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black.withOpacity(0.25),
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                     Icon(Icons.remove_red_eye, color: Colors.white),
                     SizedBox(width: 4),

                    // 🔥 dynamic view count
                    AppText(
                      widget.view,
                      fontSize: Get.height * 0.012,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                     SizedBox(width: 4),

                    Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: AppText(
                        "Live",
                        fontSize: Get.height * 0.012,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // MESSAGE BOX + SHOP ICON
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Write here...",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 18),
                      filled: true,
                      fillColor: AppColor.background,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: AppImage.svg(
                            AppIcons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                 SizedBox(width: 12),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AppImage.network(
                        "https://picsum.photos/200",
                        height: 60,
                        width: 60,
                      ),
                    ),
                    const SizedBox(height: 5),
                    AppText(
                      "Shop",
                      color: Colors.white,
                      fontSize: Get.height * 0.012,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
