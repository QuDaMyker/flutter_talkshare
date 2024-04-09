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
    StreamVideoController streamVideoController =
        Get.put(StreamVideoController(videoModel: videoModel));
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
          ? Center(
              child: LoadingAnimationWidget.flickr(
                leftDotColor: const Color(0xfffe0079),
                rightDotColor: const Color(0xff0056d6),
                size: 20,
              ),
            )
          : YoutubePlayer(
              controller: controller.ytController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {},
            ),
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
