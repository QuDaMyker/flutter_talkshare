import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/profile/widgets/circle_scale_avatar_widget.dart';
import 'package:flutter_talkshare/modules/profile/widgets/circle_winner_widget.dart';
import 'package:flutter_talkshare/modules/ranking/model/top_rank_user_model.dart';
import 'package:flutter_talkshare/modules/ranking/widgets/shake_animation_widget.dart';

class TopRankUser extends StatelessWidget {
  const TopRankUser({
    super.key,
    required this.labelHeight,
    required this.isTopOne,
    required this.size,
    required this.index,
    required this.textStyle,
    required this.topRankUserModel,
  });

  final double labelHeight;
  final bool isTopOne;
  final double size;
  final int index;
  final TextStyle textStyle;
  final TopRankUserModel topRankUserModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimationComponent(),
        Text(
          topRankUserModel.fullname,
          style: const TextStyle(
            color: AppColors.primary40,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              topRankUserModel.sum_point.toString(),
              style: const TextStyle(
                color: AppColors.secondary20,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            SvgPicture.asset(
              ImageAssets.icElectric,
            ),
          ],
        ),
      ],
    );
  }

  Stack _buildAnimationComponent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: labelHeight - 10,
            top: labelHeight,
          ),
          child: CircleWinnerWidget(
            colors: [
              AppColors.primary40,
              AppColors.secondary20,
            ],
            size: size,
            thinness: 2,
            child: CircleScaleAvatarWidget(
              image: topRankUserModel.avatar_url,
              begin: 0.9,
              end: 1,
              fit: BoxFit.cover,
              margin: const EdgeInsets.all(5),
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(ImageAssets.icBookmarkFilled),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    index.toString(),
                    style: textStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isTopOne,
          child: Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: labelHeight + 10,
              child: ShakeAnimationWidget(
                begin: 0,
                end: 6,
                child: SvgPicture.asset(ImageAssets.icCrown),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
