import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/game/controllers/waiting_controller.dart';
import 'package:get/get.dart';

class WaitingScreen extends StatelessWidget {
  WaitingScreen({super.key});
  final WaitingController controller = Get.put(WaitingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage(ImageAssets.bgWaiting)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => InkWell(
                      child: Container(
                        width: 34,
                        height: 34,
                        child: controller.countdown.value < 4
                            ? SizedBox()
                            : SvgPicture.asset(
                                ImageAssets.icBack,
                                color: Colors.white,
                              ),
                      ),
                      onTap: () {
                        controller.endRoom();
                        Get.back();
                      },
                    )),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  controller.currentUser != null
                      ? controller.currentUser!.fullname
                      : '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(controller.currentUser != null
                      ? controller.currentUser!.avatar_url
                      : 'https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg'),
                  backgroundColor: Colors.transparent,
                ),
                Obx(() => CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          controller.peerUser.value != null
                              ? controller.peerUser.value!.avatar_url
                              : "https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg"),
                      backgroundColor: Colors.transparent,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => Text(
                      controller.peerUser.value != null
                          ? controller.peerUser.value!.fullname
                          : "Đang chờ...",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Obx(() => controller.roomCode.value == ''
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ID",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: controller.roomCode.value));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Text(
                                controller.roomCode.value,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gray20),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              SvgPicture.asset(ImageAssets.icCopy)
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            SizedBox(
              height: 8,
            ),
            Obx(() => controller.countdown.value < 4
                ? SvgPicture.asset(
                    ImageAssets.txtReady,
                  )
                : SvgPicture.asset(
                    ImageAssets.txtFinding,
                  )),
            SizedBox(
              height: 20,
            ),
            Obx(() => Text(
                  controller.countdown.value < 4
                      ? "${controller.countdown.value}"
                      : "",
                  style: TextStyle(
                      fontSize: 60,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                )),
          ],
        ),
      ),
    );
  }
}
