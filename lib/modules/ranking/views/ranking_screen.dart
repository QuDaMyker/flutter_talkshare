import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/profile/widgets/circle_scale_avatar_widget.dart';
import 'package:flutter_talkshare/modules/profile/widgets/circle_winner_widget.dart';
import 'package:get/get.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double labelHeight = 50;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: labelHeight - 10),
                        child: CircleWinnerWidget(
                          colors: [
                            AppColors.primary40,
                            AppColors.secondary20,
                          ],
                          size: Get.width * 0.3,
                          thinness: 2,
                          child: CircleScaleAvatarWidget(
                            image:
                                'https://images.unsplash.com/photo-1716117274929-875f37a83fe5?q=80&w=2564&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            begin: 0.9,
                            end: 1,
                            fit: BoxFit.cover,
                            margin: const EdgeInsets.all(8),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: labelHeight,
                          child: SvgPicture.asset(ImageAssets.icBookmarkFilled),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: SvgPicture.asset(ImageAssets.icCrown),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Bảng xếp hạng',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: AppColors.primary20,
        ),
      ),
    );
  }
}
