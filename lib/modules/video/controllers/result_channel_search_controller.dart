import 'package:flutter_talkshare/modules/video/models/channel_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class ResultChannelSearchController extends GetxController {
  final ChannelModel channelModel;
  ResultChannelSearchController({required this.channelModel});

  var videos = Rx<List<VideoModel>>([]);
  var isLoading = Rx<bool>(false);

  @override
  void onInit() async {
    isLoading.value = true;
    await getListChannel(10);
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    Get.delete<ResultChannelSearchController>();
    super.onClose();
  }

  Future<void> getListChannel(int limit) async {
    videos.value = await SupabaseService.instance.getListVideoByIdChannel(
      limit: limit,
      idChannel: channelModel.id,
    );
    // print('getxong videos');

    // for (VideoModel videoModel in videos.value) {
    //   String videoId =
    //       videoModel.urlVideo.substring(videoModel.urlVideo.indexOf('=') + 1);

    //   List<CaptionResponse> listCaptionResponse =
    //       await VideoServices.instance.getCaptions(videoId);
    //   print('getxong CaptionResponse');

    //   for (CaptionResponse captionResponse in listCaptionResponse) {
    //     SubtitleModel subtitleModel = SubtitleModel(
    //       idVideo: videoModel.id,
    //       index: captionResponse.index,
    //       content: captionResponse.text,
    //       start: captionResponse.start,
    //       duration: captionResponse.dur,
    //       end: captionResponse.end,
    //     );
    //     print('${captionResponse.index}/${listCaptionResponse.length}');

    //     String kq = await SupabaseService.instance
    //         .addSubtitle(subtitleModel: subtitleModel);

    //     debugPrint(kq);
    //   }
    // }
  }
}
