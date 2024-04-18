import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/modules/video/models/caption_response.dart';
import 'package:flutter_talkshare/modules/video/models/item_caption_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamVideoController extends GetxController {
  final VideoModel videoModel;
  StreamVideoController({required this.videoModel});

  var isLoading = Rx<bool>(true);
  var captions = Rx<List<CaptionResponse>>([]);
  var originCaptions = Rx<List<CaptionResponse>>([]);
  var listCaptionsShowing = Rx<List<ItemCaptionModel>>([]);
  var currentCaption = Rx<String>('');
  late YoutubeExplode yt;
  late Video video;
  late YoutubePlayerController ytController;
  late ScrollController scrollController;
  late ItemScrollController itemScrollController;

  @override
  void onInit() async {
    yt = YoutubeExplode();

    await fetchVideoInfo();
    initScrollController();
    initYtController();
    // await getCaptions(video.id.toString());
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    yt.close();
    Get.delete<StreamVideoController>();
    super.onClose();
  }

  Future<void> fetchVideoInfo() async {
    var videoId =
        VideoId('https://www.youtube.com/watch?v=0juLRi90kRg&ab_channel=TED');
    video = await yt.videos.get(videoId);
  }

  void initScrollController() {
    scrollController = ScrollController();
    itemScrollController = ItemScrollController();
  }

  void scrollToIndex(int index) {
    // scrollController.animateTo(
    //   index * 60,
    //   duration: const Duration(seconds: 1),
    //   curve: Curves.fastOutSlowIn,
    // );
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
    );
  }

  void initYtController() {
    ytController = YoutubePlayerController(
      initialVideoId: video.id.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );
    // ytController.addListener(() {

    // });
    ytController.addListener(() {
      if (ytController.value.playerState == PlayerState.playing) {
        String duration = formatDuration(captions.value[0].start as double);
        String positon =
            formatMilliseconds(ytController.value.position.inMilliseconds);
        if (duration == positon) {
          debugPrint('compare: $duration - $positon');

          currentCaption.value =
              '${captions.value[0].start!}: ${captions.value[0].text!}';

          int selectedIndex = originCaptions.value.indexOf(captions.value[0]);

          scrollToIndex(selectedIndex);

          ItemCaptionModel itemCaptionModel = ItemCaptionModel(
              captionResponse: originCaptions.value[selectedIndex],
              isSelected: true);

          listCaptionsShowing.value = [
            ...listCaptionsShowing.value.sublist(0, selectedIndex),
            itemCaptionModel,
            ...listCaptionsShowing.value.sublist(selectedIndex + 1)
          ];

          if (listCaptionsShowing.value.length != originCaptions.value.length) {
            Get.snackbar('title',
                '${listCaptionsShowing.value.length} - ${originCaptions.value.length}');
          }
          update();

          captions.value = [...captions.value.sublist(1)];
        }
      }
    });

    print('log-data: ${video.title}');
    print('log-data: ${video.thumbnails.maxResUrl}');
    print('log-data: ${video.duration!.inSeconds}');
  }

  Future<void> getCaptions(String videoId) async {
    var headers = {
      'X-RapidAPI-Key': dotenv.get('X-RapidAPI-Key'),
      'X-RapidAPI-Host': dotenv.get('X-RapidAPI-Host')
    };
    var data = '''''';
    var dio = Dio();
    var response = await dio.request(
      'https://subtitles-for-youtube.p.rapidapi.com/subtitles/$videoId',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      captions.value = (response.data as List<dynamic>)
          .map((item) => CaptionResponse.fromMap(item))
          .toList();
      originCaptions.value = [...captions.value];
      listCaptionsShowing.value = originCaptions.value
          .map((item) => ItemCaptionModel(captionResponse: item))
          .toList();
    } else {
      debugPrint('response.statusMessage: ${response.statusMessage}');
    }
  }
}
