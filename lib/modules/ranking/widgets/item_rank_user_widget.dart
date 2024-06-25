import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/ranking/model/top_rank_user_model.dart';

class ItemRankUserWidget extends StatelessWidget {
  const ItemRankUserWidget({
    super.key,
    required this.item,
    required this.index,
  });

  final TopRankUserModel item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.rectangle,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: AppColors.gray20,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      item.avatar_url,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  item.fullname,
                  style: const TextStyle(
                    color: AppColors.primary20,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      item.sum_point.toString(),
                      style: const TextStyle(
                        color: AppColors.secondary20,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      ImageAssets.icElectric,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: AppColors.gray40,
          indent: 10,
        )
      ],
    );
  }
}
