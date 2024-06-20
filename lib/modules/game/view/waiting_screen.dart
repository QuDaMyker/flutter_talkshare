import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                InkWell(
                  child: Container(
                    width: 34,
                    height: 34,
                    child: SvgPicture.asset(
                      ImageAssets.icBack,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(
                  controller.roomId,
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
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                  backgroundColor: Colors.transparent,
                ),
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Lê Bảo Như",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Obx(() => Text(
                  "Game starts in: ${controller.countdown.value}",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
