import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/video/models/channel_model.dart';
import 'package:flutter_talkshare/modules/video/views/result_channel_search_srceen.dart';

class ItemChannel extends StatelessWidget {
  const ItemChannel({
    super.key,
    required this.channelModel,
  });
  final ChannelModel channelModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ResultChannelSearchScreen(channelModel: channelModel),
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        channelModel.imgUrlBrand,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Text(
                        channelModel.nameOfBrand,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary20,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                ImageAssets.arrowRight,
                colorFilter: const ColorFilter.mode(
                  AppColors.gray20,
                  BlendMode.srcIn,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
