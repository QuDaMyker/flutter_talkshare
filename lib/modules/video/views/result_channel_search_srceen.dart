import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/video/controllers/result_channel_search_controller.dart';
import 'package:flutter_talkshare/modules/video/models/channel_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/modules/video/widgets/item_video.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResultChannelSearchScreen extends StatefulWidget {
  const ResultChannelSearchScreen({
    super.key,
    required this.channelModel,
  });
  final ChannelModel channelModel;

  @override
  State<ResultChannelSearchScreen> createState() =>
      _ResultChannelSearchScreenState();
}

class _ResultChannelSearchScreenState extends State<ResultChannelSearchScreen> {
  late ResultChannelSearchController resultChannelSearchController;
  @override
  void initState() {
    resultChannelSearchController = Get.put(
        ResultChannelSearchController(channelModel: widget.channelModel));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ResultChannelSearchController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(widget.channelModel.nameOfBrand),
        body: _buildBody(resultChannelSearchController),
      ),
    );
  }

  Padding _buildBody(ResultChannelSearchController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(
        () => controller.isLoading.value
            ? _buildLoading()
            : controller.videos.value.isEmpty
                ? const Center(
                    child: Text('Khong co data'),
                  )
                : ListView.builder(
                    itemCount: controller.videos.value.length,
                    itemBuilder: (context, index) {
                      VideoModel videoModel = controller.videos.value[index];
                      return ItemVideo(
                        videoModel: VideoModel(
                          id: videoModel.id,
                          title: videoModel.title,
                          thumbnail: videoModel.thumbnail,
                          duration: videoModel.duration,
                          urlVideo: videoModel.urlVideo,
                          channel: videoModel.channel,
                        ),
                      );
                    },
                  ),
      ),
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
