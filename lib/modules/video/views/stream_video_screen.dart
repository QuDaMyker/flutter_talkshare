import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/constants.dart';
import 'package:flutter_talkshare/modules/video/controllers/stream_video_controller.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamVideo extends StatelessWidget {
  const StreamVideo({
    super.key,
    required this.optionView,
    required this.videoModel,
  });
  final String optionView;
  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    StreamVideoController streamVideoController = Get.put(
        StreamVideoController(videoModel: videoModel),
        tag: videoModel.id);
    return SafeArea(
      child: Scaffold(
        appBar:
            _buildAppBar(optionView == Constants.sub ? 'Phụ đề' : 'Điền từ'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: _buildBody(streamVideoController),
        ),
      ),
    );
  }

  Widget _buildBody(StreamVideoController controller) {
    return Obx(
      () => controller.isLoading.value
          ? _buildLoading()
          : _buildVideoPlayer(controller),
    );
  }

  Center _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: const Color(0xfffe0079),
        rightDotColor: const Color(0xff0056d6),
        size: 20,
      ),
    );
  }

  Widget _buildVideoPlayer(StreamVideoController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: YoutubePlayer(
            controller: controller.ytController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {},
          ),
        ),
        Expanded(
          flex: 5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Text(
                  controller.video.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 12,
                ),
                /* Text(controller.video.description),
                Text(controller.video.url),
                Text(controller.video.author),
                Text(controller.video.channelId.toString()),
                Text(controller.video.id.toString()), */
                // Obx(
                //   () => Column(
                //     children: controller.captions.value
                //         .map(
                //           (caption) => Text(caption.text!),
                //         )
                //         .toList(),
                //   ),
                // ),

                Obx(() => Text(controller.currentCaption.value))
              ],
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(String nameOfBranch) {
    return AppBar(
      centerTitle: true,
      title: Text(
        nameOfBranch,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
