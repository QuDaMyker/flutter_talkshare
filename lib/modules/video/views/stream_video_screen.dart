import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/constants.dart';
import 'package:flutter_talkshare/modules/video/controllers/stream_video_controller.dart';
import 'package:flutter_talkshare/modules/video/models/item_caption_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/modules/video/widgets/item_caption_widget.dart';

class StreamVideo extends StatefulWidget {
  const StreamVideo({
    super.key,
    required this.optionView,
    required this.videoModel,
  });
  final String optionView;
  final VideoModel videoModel;

  @override
  State<StreamVideo> createState() => _StreamVideoState();
}

class _StreamVideoState extends State<StreamVideo> {
  late StreamVideoController streamVideoController;
  @override
  void initState() {
    streamVideoController = Get.put(
      StreamVideoController(
        videoModel: widget.videoModel,
        isModeTitle: widget.optionView == Constants.sub,
      ),
      // tag: widget.videoModel.id);
    );
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<StreamVideoController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(
            widget.optionView == Constants.sub ? 'Phụ đề' : 'Điền từ'),
        body: _buildBody(streamVideoController),
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
        leftDotColor: AppColors.primary40,
        rightDotColor: AppColors.secondary20,
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
          child: _buildYoutubeView(controller),
        ),
        _buildVideoTitle(controller),
        Expanded(
          flex: 4,
          child: widget.optionView == Constants.sub
              ? _buildScrollTitle(controller)
              : Obx(
                  () => SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 12),
                          decoration: const BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: controller.listSubSplit.value
                                .mapIndexed((index, text) {
                              if (controller.blankIndexes.value
                                  .contains(index)) {
                                return Expanded(
                                  child: Container(
                                    width: 100,
                                    child: TextField(),
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: Text(
                                    controller.listSubSplit.value[index],
                                  ),
                                );
                              }
                            }).toList(),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          width: 60,
                          child: Container(
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: AppColors.primary40,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Container _buildYoutubeView(StreamVideoController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          top: BorderSide(width: 1, color: AppColors.primary20),
          bottom: BorderSide(width: 1, color: AppColors.primary20),
          right: BorderSide(width: 1, color: AppColors.primary20),
          left: BorderSide(width: 1, color: AppColors.primary20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
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
    );
  }

  Widget _buildVideoTitle(StreamVideoController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '${controller.video.title}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Obx _buildScrollTitle(StreamVideoController controller) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ScrollablePositionedList.builder(
          itemScrollController: controller.itemScrollController,
          itemCount: controller.listCaptionsShowing.value.length,
          itemBuilder: (context, index) {
            ItemCaptionModel itemCaptionModel =
                controller.listCaptionsShowing.value[index];
            return ItemCaptionWidget(
              itemCaptionModel: itemCaptionModel,
            );
          },
        ),
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
