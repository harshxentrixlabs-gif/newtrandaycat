import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/home_screen/controller/home_controller.dart';
import 'package:video_player/video_player.dart';
import '../../app_string/app_string.dart';
import '../../utils/app_color.dart';
import '../../utils/common/app_image.dart';
import 'controller/shorts_controller.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  final ShortsController controller = Get.put(ShortsController());

  final box = GetStorage();

  late String userName = box.read('userName') ?? "Guest User";
  late String userEmail = box.read('userEmail') ?? "";
  late String userPhoto = box.read('userPhoto') ??
      "https://cdn-icons-png.flaticon.com/512/149/149071.png";

  HomeController homeController = Get.find();


  @override
  void initState() {
    super.initState();

    homeController.productMethods();

    // INITIAL VIDEO LOAD
    if (homeController.reel.isNotEmpty) {
      controller.initVideo(homeController.reel[0].video);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<ShortsController>(
        builder: (controller) {
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: homeController.reel.length,
            onPageChanged: (index) {
              controller.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              final data = homeController.reel[index];
              return Stack(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: controller.togglePlayPause,
                      child: controller.videoController.value.isInitialized
                          ? ClipRect(
                        child: Align(
                          alignment: Alignment.center,
                          heightFactor: 0.998,
                          widthFactor: 0.998,
                          child: VideoPlayer(controller.videoController),
                        ),
                      )
                          : Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                    ,
                  ),
                  Positioned(
                    bottom: 150,
                    right: 20,
                    child: Column(
                      children: [
                        commonButton(Icons.favorite_border, () {}),
                        SizedBox(height: 10),
                        commonButton(Icons.share, () {}),
                        SizedBox(height: 10),
                        commonButton(Icons.more_vert, () {}),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: AppText(
                              'User Info & Caption',
                              color: AppColor.primary,
                              fontSize: Get.height * 0.010,
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.010),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Container(
                                  width: Get.width * 0.09,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    userPhoto,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width * 0.020),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    AppText(
                                     userName,
                                      fontSize: Get.height * 0.015,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textWhite,
                                    ),
                                    SizedBox(width: Get.width * 0.020),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.3,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 8.0,
                                          right: 8,
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        child: AppText(
                                          'Follow',
                                          color: Colors.white,
                                          fontSize: Get.height * 0.009,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                AppText(
                                  userEmail,
                                  fontSize: Get.height * 0.012,
                                  color: AppColor.textWhite,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.010),
                        AppText(
                          'User Info & Caption',
                          color: Colors.white,
                          fontSize: Get.height * 0.014,
                          overflow: TextOverflow.ellipsis,
                        ),
                       Obx(()=> SizedBox(
                          height: Get.height * 0.10,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: homeController.product.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = homeController.product[index];
                              AppLogs.log(" reels ${data}");
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0, top: 8),
                                child: Container(
                                  width: Get.width * 0.65,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: AppImage.network(
                                            width: Get.width * 0.14,
                                            height: Get.height * 0.14,
                                            data.mainImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.030),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: AppText(
                                                  data.productName,
                                                  color: AppColor.textWhite,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Expanded(
                                                child: AppText(
                                                  data.description,
                                                  color: AppColor.textWhite,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: Get.height * 0.010,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    AppText(
                                                      "\$${data.price}",
                                                      color: AppColor.primary,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColor.primary,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                10,
                                                              ),
                                                            ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                              left: 15.0,
                                                              right: 15,
                                                              top: 2,
                                                              bottom: 2,
                                                            ),
                                                        child: AppText(
                                                          AppString.byNow,
                                                          color: AppColor
                                                              .textWhite,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              Get.height *
                                                              0.012,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                       ),
                      ],
                    ),
                  ),

                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget commonButton(IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: Colors.white),
        ),
      ),
    );
  }
}
