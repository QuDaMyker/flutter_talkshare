import 'package:expandable_text/expandable_text.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/enums/community_tab.dart';
import 'package:flutter_talkshare/core/models/audio_room.dart';
import 'package:flutter_talkshare/core/models/livestream.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/community/controllers/community_controller.dart';
import 'package:flutter_talkshare/modules/community/view/audio_room_page.dart';
import 'package:flutter_talkshare/modules/community/view/create_audio_room.dart';
import 'package:flutter_talkshare/modules/community/view/post_blog_screen.dart';
import 'package:flutter_talkshare/modules/community/view/live_page.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CommnityScreen extends StatelessWidget {
  CommnityScreen({super.key});
  CommunityController controller = Get.put(CommunityController());


  // List<String> url = ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
  //  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
  //  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
  //  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: "Tạo phòng nói",
            iconColor: Colors.white,
            bubbleColor: AppColors.primary40,
            icon: CupertinoIcons.mic_fill,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              controller.animationController.reverse();
              // Get.to(AudioRoomPage(roomID: '123', isHost: true,));
              Get.to(CreateAudioRoom());
            },
          ),
          Bubble(
            title: "Tạo livestream",
            iconColor: Colors.white,
            bubbleColor: AppColors.primary40,
            icon: CupertinoIcons.videocam_fill,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              controller.animationController.reverse();
              var uuid = const Uuid();
              String streamId = uuid.v4();
              controller.creatLivestream(streamId);
              Get.back();
              Get.to(LivePage(
                isHost: true,
                liveID: streamId,
              ));
            },
          ),
        ],
        animation: controller.animation,
        onPress: () => controller.selectedTab.value == CommunityTab.INTERACTION
          ? (controller.animationController.isCompleted
            ? controller.animationController.reverse()
            : controller.animationController.forward(),)
          : (Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostBlogScreen()),
              ),
            ),
        iconColor: AppColors.primary40,
        iconData: CupertinoIcons.add_circled_solid,
        backGroundColor: AppColors.secondary90,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          String type = controller.selectedType.value != 0
              ? (controller.selectedType.value == 1 ? "Công khai" : "Riêng tư")
              : "Tất cả";
          controller.filter(type);
          controller.listStream.clear();
          controller.listStream
              .addAll(await SupabaseService.instance.getAllLivestream());
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => Row(
                          children: [
                            Expanded(
                                child: ToggleButton(
                                    type: CommunityTab.INTERACTION)),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                child: ToggleButton(type: CommunityTab.BLOG)),
                          ],
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icMicrophone),
                        const SizedBox(
                          width: 4,
                        ),
                        const Expanded(
                            child: Text(
                          "Phòng nói",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary20,
                              fontWeight: FontWeight.w700),
                        )),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                builder: (context) {
                                  return Obx(() => Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Lọc theo loại phòng",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color:
                                                            AppColors.primary20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: SvgPicture.asset(
                                                      ImageAssets.icClose2),
                                                )
                                              ],
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Tất cả",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .primary20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              trailing: Transform.scale(
                                                scale: 1,
                                                child: Radio(
                                                  groupValue: controller
                                                      .selectedType.value,
                                                  value: 0,
                                                  activeColor:
                                                      AppColors.secondary20,
                                                  onChanged: (int? value) {
                                                    controller.selectedType
                                                        .value = value ?? 0;
                                                    controller.filter("Tất cả");
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                              onTap: () {
                                                // Get.back();
                                              },
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Công khai",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .primary20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              trailing: Transform.scale(
                                                scale: 1,
                                                child: Radio(
                                                  groupValue: controller
                                                      .selectedType.value,
                                                  value: 1,
                                                  activeColor:
                                                      AppColors.secondary20,
                                                  onChanged: (int? value) {
                                                    controller.selectedType
                                                        .value = value ?? 0;
                                                    controller
                                                        .filter("Công khai");
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                              onTap: () {
                                                // Get.back();
                                              },
                                            ),
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Riêng tư",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: AppColors
                                                              .primary20,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              trailing: Transform.scale(
                                                scale: 1,
                                                child: Radio(
                                                  groupValue: controller
                                                      .selectedType.value,
                                                  value: 2,
                                                  activeColor:
                                                      AppColors.secondary20,
                                                  onChanged: (int? value) {
                                                    controller.selectedType
                                                        .value = value ?? 0;
                                                    controller
                                                        .filter("Riêng tư");
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                              onTap: () {
                                                // Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      ));
                                });
                          },
                          child: SvgPicture.asset(ImageAssets.icFilter),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(() => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AudioRoomItem(
                              context, controller.listRoom[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 16,
                            ),
                        itemCount: controller.listRoom.length)),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(ImageAssets.icLivestream),
                        const SizedBox(
                          width: 4,
                        ),
                        const Expanded(
                            child: Text(
                          "Livestream",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary20,
                              fontWeight: FontWeight.w700),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(() => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return LivestreamItem(controller.listStream[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 16,
                            ),
                        itemCount: controller.listStream.length)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ToggleButton({required CommunityTab type}) {
    bool isSelected = controller.selectedTab.value == type;
    return InkWell(
      onTap: () {
        controller.selectedTab.value = type;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary20 : AppColors.gray80,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          type.getName(),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.gray20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget LivestreamItem(Livestream livestream) {
    var currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    var roomCreatedAt = livestream.createdAt!;
    var timeDifference = currentTime - roomCreatedAt;
    var minutesAgo = (timeDifference / (1000 * 60)).floor();
    var hoursAgo = (timeDifference / (1000 * 60 * 60)).floor();
    //TODO: query user information

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
            image: const NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lê Bảo Như",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  minutesAgo < 60
                      ? "$minutesAgo phút trước"
                      : "$hoursAgo giờ trước",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColors.secondary20,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Tham gia",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          )
        ],
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Row(
                children: [
                  Expanded(
                      child: ToggleButton(type: CommunityTab.INTERACTION)),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(child: ToggleButton(type: CommunityTab.BLOG)),
                ],
              )),
              const SizedBox(
                height: 16,
              ),

            Obx(() => controller.selectedTab.value == CommunityTab.INTERACTION
              ? Interaction(context)
              : Blog(context),
            )

            ],
          ),
        ),
      ),
    );
  }

  Column Interaction(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(ImageAssets.icMicrophone),
            const SizedBox(
              width: 4,
            ),
            const Expanded(
                child: Text(
              "Phòng nói",
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary20,
                  fontWeight: FontWeight.w700),
            )),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    useRootNavigator: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Lọc theo loại phòng",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.primary20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                      ImageAssets.icClose2),
                                )
                              ],
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Tất cả",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primary20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              trailing: Transform.scale(
                                scale: 1,
                                child: Radio(
                                  groupValue: 1,
                                  value: 0,
                                  activeColor: AppColors.secondary20,
                                  onChanged: (int? value) {
                                    // Get.back();
                                  },
                                ),
                              ),
                              onTap: () {
                                // Get.back();
                              },
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Công khai",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primary20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              trailing: Transform.scale(
                                scale: 1,
                                child: Radio(
                                  groupValue: 1,
                                  value: 1,
                                  activeColor: AppColors.secondary20,
                                  onChanged: (int? value) {
                                    // Get.back();
                                  },
                                ),
                              ),
                              onTap: () {
                                // Get.back();
                              },
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Riêng tư",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primary20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              trailing: Transform.scale(
                                scale: 1,
                                child: Radio(
                                  groupValue: 1,
                                  value: 2,
                                  activeColor: AppColors.secondary20,
                                  onChanged: (int? value) {
                                    // Get.back();
                                  },
                                ),
                              ),
                              onTap: () {
                                // Get.back();
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: SvgPicture.asset(ImageAssets.icFilter),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return AudioRoomItem(context);
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
            itemCount: 2),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            SvgPicture.asset(ImageAssets.icLivestream),
            const SizedBox(
              width: 4,
            ),
            const Expanded(
                child: Text(
              "Livestream",
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary20,
                  fontWeight: FontWeight.w700),
            )),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                image: const NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.darken)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Free room early",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "7",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset(ImageAssets.icUsersWhite)
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "20 phút trước",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          color: AppColors.secondary20,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        "Tham gia",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget ToggleButton({required CommunityTab type}) {
    bool isSelected = controller.selectedTab.value == type;
    return InkWell(
      onTap: () {
        controller.selectedTab.value = type;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary20 : AppColors.gray80,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          type.getName(),
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.gray20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget AudioRoomItem(BuildContext context, AudioRoom room) {
    var currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    var roomCreatedAt = room.createdAt!;
    var timeDifference = currentTime - roomCreatedAt;
    var minutesAgo = (timeDifference / (1000 * 60)).floor();
    var hoursAgo = (timeDifference / (1000 * 60 * 60)).floor();

    return GestureDetector(
      onTap: () {
        if (room.passcode != null) {
          showPasscodeModal(context, room);
        } else {
          Get.to(AudioRoomPage(
            roomID: room.roomId,
            isHost: false,
          ));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              blurRadius: 8,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: room.passcode == null
                        ? LinearGradient(
                            colors: AppColors.primaryGradient,
                          )
                        : null,
                    color: room.passcode == null ? null : AppColors.gray60,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(room.passcode == null
                          ? ImageAssets.icUnlock
                          : ImageAssets.icLock),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        room.passcode == null ? "Công khai" : "Riêng tư",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: room.passcode == null
                                ? Colors.white
                                : AppColors.gray20),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  room.quantity.toString(),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary40),
                ),
                const SizedBox(
                  width: 4,
                ),
                SvgPicture.asset(
                  ImageAssets.icMicrophone,
                  width: 16,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              room.name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary20),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              room.topic,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray20),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    minutesAgo < 60
                        ? "$minutesAgo phút trước"
                        : "$hoursAgo giờ trước",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray40),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                        color: AppColors.secondary20,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      "Tham gia",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  showPasscodeModal(BuildContext context, AudioRoom room) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Passcode",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primary20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(ImageAssets.icClose2),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    controller: controller.confirmPasscodeCtrl,
                    cursorColor: AppColors.primary40,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary20,
                        fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Nhập passcode',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray40,
                      ),
                      focusedBorder: customBorderWhenFocus(),
                      enabledBorder: customBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      if (controller.confirmPasscodeCtrl.text ==
                          room.passcode.toString()) {
                        Get.to(AudioRoomPage(
                          roomID: room.roomId,
                          isHost: false,
                        ));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.secondary20,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Cộng đồng',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.primary20),
      ),
    );
  }

  Column Blog(BuildContext context) {
    return Column(
      children: [
        // Obx(()=>
        SingleChildScrollView(
            child: SizedBox(
              height: 900,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                scrollDirection: Axis.vertical,
                itemCount: 6,
                itemBuilder: (context, index) {
                  // IrregularVerb verb = controller.searched_list[index];
                  return  BlogItem(context);
                  // ItemIrregularVerbs(
                  //   infinitive: verb.infinitive,
                  //   pastSimple: verb.pastSimple,
                  //   pastParticiple: verb.pastParticiple,
                  //   meaning: verb.meaning,
                  // );
                },
              ),
            ),
        ),
        // ),
      ],

    );
  }

  Container BlogItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                      backgroundColor: Colors.transparent,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(ImageAssets.icStar),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              "Teacher",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondary20),
                            )
                          ],
                        ),
                        const Text(
                          "Divid",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                "4 giờ trước",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          ExpandableText(
            "Nguyên âm và phụ âm - phần kiến thức quan trọng xuất hiện trong mọi kỳ thi tiếng anh. bạn đã nắm được hết? \n Hôm nay cô giới thiệu tới các bạn bộ nguyên âm",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            expandText: 'Xem thêm',
            collapseText: 'Thu gọn',
            maxLines: 5,
          ),
          const SizedBox(
            height: 10,
          ),
          //_buildSingleImagePost('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',context)
          //_buildFourImagesPost(url),
            _buildMultipleImagePost(url),
        ],
      ),
    );
  }
  List<String> url = ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s',
   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'];


  Widget _buildSingleImagePost(String imageUrl, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GestureDetector(
        onTap: () {},
        child: ClipRRect(
          child: Image.network(
            imageUrl,
            width: 350,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFourImagesPost(List<String> imageUrls) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        shrinkWrap: true,
        children: imageUrls.map((url) => GestureDetector(
          onTap: () {
            // Xử lý khi nhấn vào hình ảnh
          },
          child: ClipRRect(
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ),).toList(),
      ),
    );
  }

  Widget _buildMultipleImagePost(List<String> imageUrls) {
    List<Widget> gridItems = imageUrls.sublist(0, 3).map((url) => _buildImageItem(url)).toList();

    gridItems.add(
      GestureDetector(
        onTap: () {
          // Xử lý khi nhấn vào hình ảnh thứ tư
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                child: Image.network(
                  imageUrls[3],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      shrinkWrap: true,
      children: gridItems,
    ),
  );
  }

  Widget _buildImageItem(String imageUrl) {
    return GestureDetector(
      onTap: () {
      },
      child: ClipRRect(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }


}
