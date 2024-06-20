import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/game/controllers/game_controller.dart';
import 'package:flutter_talkshare/modules/game/view/play_with_friend_screen.dart';
import 'package:flutter_talkshare/modules/game/view/waiting_screen.dart';
import 'package:get/get.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});
  GameController controller = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 120, 20, 20),
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.secondaryGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          children: [
            Image.asset(
              ImageAssets.gameTitle,
              width: Get.width * 0.7,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT5Uw9KngKXAwYmjplN3_ANBA51ou4fzAdaLZNf23Nkg&s'),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.currentUser?.fullname ?? '',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Row(
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
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Text(
                                "0987654321",
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
                        )
                      ],
                    )
                  ],
                )),
                SizedBox(width: 50),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Text(
                            "Thắng",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF219F94)),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "5",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Text(
                            "Thua",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFF5252)),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "5",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                controller.onPlayRandom();
              },
              child: Container(
                  width: Get.width - 100,
                  child: Image.asset(ImageAssets.btnRandom)),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(PlayWithFriendScreen());
              },
              child: Container(
                  width: Get.width - 100,
                  child: Image.asset(ImageAssets.btnFriend)),
            ),
          ],
        ),
      ),
    );
  }
}
