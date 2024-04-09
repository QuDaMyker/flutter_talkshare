import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/constants.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/modules/video/views/stream_video_screen.dart';

class ItemVideo extends StatelessWidget {
  const ItemVideo({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOption('Xem với phụ đề', () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StreamVideo(
                        optionView: Constants.sub, videoModel: videoModel),
                  ));
                }),
                const SizedBox(
                  height: 10,
                ),
                _buildOption('Xem và điền từ vào chỗ trống', () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StreamVideo(
                        optionView: Constants.nonSub, videoModel: videoModel),
                  ));
                }),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: AppColors.gray80,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: deviceWidth * 0.85,
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(videoModel.imgUrlVideo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: deviceWidth * 0.31,
                  left: deviceWidth * 0.31,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: SvgPicture.asset(
                      ImageAssets.icPlay,
                      fit: BoxFit.cover,
                      height: deviceWidth * 0.08,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: AppColors.gray40.withOpacity(0.7),
                    ),
                    child: Text(
                      '3:10',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  videoModel.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                CircleAvatar(
                  maxRadius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                    videoModel.imgUrlBrand,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  videoModel.nameOfBrand,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.gray20,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String title, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: AppColors.secondary20,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
