import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/community/controllers/community_controller.dart';
import 'package:flutter_talkshare/modules/community/view/audio_room_page.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:uuid/uuid.dart';

class CreateAudioRoom extends StatelessWidget {
  CreateAudioRoom({super.key});
  CommunityController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: AppColors.backgroundGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: _builBody(deviceHeight, deviceWidth)),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Tạo phòng nói',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.primary20),
      ),
      leading: InkWell(
        child: Container(
          width: 34,
          height: 34,
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        onTap: () {
          Get.back();
        },
      ),
    );
  }

  Padding _builBody(
    double deviceHeight,
    double deviceWidth,
  ) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: deviceHeight * 0.02, horizontal: deviceWidth * 0.05),
        child: SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tên phòng',
                      style: TextStyle(
                        color: AppColors.primary20,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: controller.roomNameCtrl,
                      cursorColor: AppColors.primary40,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary20,
                          fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Nhập tên phòng',
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray40,
                        ),
                        focusedBorder: customBorderWhenFocus(),
                        enabledBorder: customBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Chủ đề phòng nói',
                      style: TextStyle(
                        color: AppColors.primary20,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: controller.roomTopicCtrl,
                      cursorColor: AppColors.primary40,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary20,
                          fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Nhập chủ đề',
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gray40,
                        ),
                        focusedBorder: customBorderWhenFocus(),
                        enabledBorder: customBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Số lượng người nói',
                      style: TextStyle(
                        color: AppColors.primary20,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(() => NumberPicker(
                        value: controller.speakerNum.value,
                        minValue: 2,
                        maxValue: 16,
                        axis: Axis.horizontal,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.primary40),
                        ),
                        onChanged: (value) =>
                            controller.speakerNum.value = value)),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Riêng tư',
                            style: TextStyle(
                              color: AppColors.primary20,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Obx(() => Switch(
                              value: controller.isPrivateRoom.value,
                              activeColor: AppColors.primary40,
                              activeTrackColor: AppColors.secondary60,
                              onChanged: (bool value) {
                                controller.isPrivateRoom.value = value;
                              },
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(
                      () => TextField(
                        controller: controller.passcodeCtrl,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.primary40,
                        enabled: controller.isPrivateRoom.value,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary20,
                            fontSize: 16),
                        decoration: InputDecoration(
                          labelText: 'Đặt passcode',
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray40,
                          ),
                          focusedBorder: customBorderWhenFocus(),
                          enabledBorder: customBorder(),
                          disabledBorder: customBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        var uuid = const Uuid();
                        String roomId = uuid.v4();
                        controller.creatRoom(roomId);
                        Get.back();
                        Get.to(AudioRoomPage(
                          roomID: roomId,
                          isHost: true,
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.secondary20,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          'Lưu',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ]),
            )));
  }
}
