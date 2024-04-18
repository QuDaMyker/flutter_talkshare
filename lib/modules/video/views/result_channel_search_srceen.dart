import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/video/controllers/result_channel_search_controller.dart';
import 'package:flutter_talkshare/modules/video/models/channel_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/modules/video/widgets/item_video.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ResultChannelSearchScreen extends StatelessWidget {
  const ResultChannelSearchScreen({
    super.key,
    required this.channelModel,
  });
  final ChannelModel channelModel;

  @override
  Widget build(BuildContext context) {
    ResultChannelSearchController resultChannelSearchController =
        Get.put(ResultChannelSearchController());
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(channelModel.nameOfBrand),
        body: _buildBody(resultChannelSearchController),
      ),
    );
  }

  Padding _buildBody(ResultChannelSearchController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(
        () => controller.isLoading.value
            ? Center(
                child: LoadingAnimationWidget.flickr(
                  leftDotColor: const Color(0xfffe0079),
                  rightDotColor: const Color(0xff0056d6),
                  size: 20,
                ),
              )
            : controller.videos.value.isNotEmpty
                ? const Center(
                    child: Text('Khong co data'),
                  )
                : ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ItemVideo(
                        videoModel: VideoModel(
                          id: 'id',
                          title:
                              """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.""",
                          imgUrlVideo:
                              'https://images.unsplash.com/photo-1521708266372-b3547456cc2d?q=80&w=2638&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          channelModel: ChannelModel(
                              id: 'id',
                              imgUrlBrand:
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxnjvHtVvnD1LLaCI0PN5czRV8QihU8MPW5ywAiFWOCQ&s',
                              nameOfBrand: 'nameOfBrand'),
                        ),
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
