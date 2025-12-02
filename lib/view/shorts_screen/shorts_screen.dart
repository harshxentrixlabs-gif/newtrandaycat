import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trendycart/utils/app_icons.dart';
import 'package:trendycart/utils/app_print.dart';
import 'package:trendycart/utils/common/app_text.dart';
import 'package:trendycart/view/home_screen/controller/home_controller.dart';
import 'package:video_player/video_player.dart';
import '../../app_string/app_string.dart';
import '../../utils/app_color.dart';
import '../../utils/common/app_button_v1.dart';
import '../../utils/common/app_image.dart';
import '../../utils/common/app_loader.dart';
import '../../utils/common/widgets.dart';
import '../../utils/common_font.dart';
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
  late String userPhoto =
      box.read('userPhoto') ??
      "https://cdn-icons-png.flaticon.com/512/149/149071.png";

  HomeController homeController = Get.find();

  @override
  void initState() {
    super.initState();

    if (controller.reel.isNotEmpty) {
      controller.initVideo(controller.reel[0].video);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      body: GetBuilder<ShortsController>(
        builder: (controller) {
          return Obx(
            () => PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.reel.length,
              onPageChanged: (index) {
                controller.onPageChanged(index);
              },
              itemBuilder: (context, index) {
                final data = controller.reel[index];
                return Stack(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: controller.togglePlayPause,
                        child: controller.videoController.value.isInitialized
                            ? ClipRect(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: VideoPlayer(
                                    controller.videoController,
                                  ),
                                ),
                              )
                            : Center(
                                child: AppLoaderWidget(),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: Get.height * 0.22,
                      right: 20,
                      child: Column(
                        children: [
                          commonButton(
                            Icon(
                              data.isLike
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            () {
                              controller.toggleLike(index);
                            },
                            color: data.isLike ? Colors.red : Colors.white,
                          ),
                          SizedBox(height: 10),
                          commonButton(
                            AppImage.svg(AppIcons.share, color: Colors.white),
                            () {},
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: Get.height * 0.8,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: Get.context!,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            builder: (_) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        "Report this product",
                                        fontSize: Get.height * 0.018,
                                        fontFamily: AppFont.bold,
                                      ),
                                      SizedBox(height: 300),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 60,
                                              child: OutlineWhiteButton(
                                                text: "CANCEL",
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: SizedBox(
                                              height: 60,
                                              child: CommonBlackButton(
                                                title: "Report",
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 10,
                            ),
                            child: AppText(
                              'Report',
                              color: Colors.white,
                              fontSize: Get.height * 0.012,
                              fontFamily: AppFont.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.010),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Container(
                                    width: Get.width * 0.11,
                                    height: 50,
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
                                        fontFamily: AppFont.medium,
                                        color: AppColor.textWhite,
                                      ),
                                      SizedBox(width: Get.width * 0.020),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.primary,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 12.0,
                                            right: 12,
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: AppText(
                                            'Follow',
                                            color: Colors.white,
                                            fontSize: Get.height * 0.009,
                                            fontFamily: AppFont.medium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppText(
                                    userEmail,
                                    fontSize: Get.height * 0.012,
                                    color: AppColor.textWhite,
                                    fontFamily: AppFont.regular,
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
                            fontFamily: AppFont.regular,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Obx(
                            () => SizedBox(
                              height: Get.height * 0.10,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeController.justForYouProduct.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = homeController.justForYouProduct[index];
                                  AppLogs.log(" reels ${data}");
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: 8.0,
                                      top: 8,
                                    ),
                                    child: Container(
                                      width: Get.width * 0.65,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.3,
                                        ),
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
                                                width: Get.width * 0.20,
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
                                                      fontFamily: AppFont.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Expanded(
                                                    child: AppText(
                                                      data.description,
                                                      color: AppColor.textWhite,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          Get.height * 0.010,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: AppText(
                                                          "\$ ${data.price}",
                                                          color: AppColor.price,
                                                          fontFamily: AppFont.bold,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: AppColor
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    100,
                                                                  ),
                                                                ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  left: 15.0,
                                                                  right: 15,
                                                                  top: 8,
                                                                  bottom: 8,
                                                                ),
                                                            child: AppText(
                                                              AppString.byNow,
                                                              color: AppColor
                                                                  .textWhite,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontFamily: AppFont.bold,
                                                              fontSize:
                                                                  Get.height *
                                                                  0.012,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
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
            ),
          );
        },
      ),
    );
  }

  Widget commonButton(Widget icon, Function() onTap, {required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconTheme(
            data: IconThemeData(color: color, size: 24),
            child: icon,
          ),
        ),
      ),
    );
  }
}
