import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';

class PlayWithFriendScreen extends StatelessWidget {
  const PlayWithFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage(ImageAssets.bgCreateGame)),
      ),
      child: SingleChildScrollView(
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
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Image.asset(
              ImageAssets.gameTitle,
              width: Get.width * 0.7,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Chơi cùng bạn bè",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {},
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary20,
                        fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Nhập ID của bạn bè',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray40,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset(ImageAssets.icThumbtack),
                      ),
                      focusedBorder: Helper.instance.customBorderWhenFocus(),
                      enabledBorder: Helper.instance.customBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.gray80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ID của bạn: ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary20),
                        ),
                        Text(
                          "0987654321",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gray20),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          ImageAssets.icCopy,
                          width: 20,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.secondary20,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        'Bắt đầu',
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
            )
          ],
        ),
      ),
    ));
  }
}
