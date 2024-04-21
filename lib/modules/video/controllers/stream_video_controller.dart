import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/video/models/item_caption_model.dart';
import 'package:flutter_talkshare/modules/video/models/subtitle_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/modules/video/services/video_services.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamVideoController extends GetxController {
  final VideoModel videoModel;
  final bool isModeTitle;
  StreamVideoController({
    required this.videoModel,
    required this.isModeTitle,
  });

  var isLoading = Rx<bool>(true);
  var isTimeout = Rx<bool>(false);
  var captions = Rx<List<SubtitleModel>>([]);
  var originCaptions = Rx<List<SubtitleModel>>([]);
  var listCaptionsShowing = Rx<List<ItemCaptionModel>>([]);
  var currentCaption = Rx<String>('');

  var paragraph = Rx<String>('');
  var listSubSplit = Rx<List<String>>([]);
  var blankIndexes = Rx<List<int>>([]);

  late YoutubeExplode yt;
  late Video video;
  late YoutubePlayerController ytController;
  late ScrollController scrollController;
  late ItemScrollController itemScrollController;

  @override
  void onInit() async {
    yt = YoutubeExplode();
    await fetchVideoInfo();
    await getCaptions(videoModel.id);
    initScrollController();
    initYtController();
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
    var videoId = VideoId(videoModel.urlVideo);
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
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        controlsVisibleAtStart: false,
        hideThumbnail: true,
        forceHD: true,
        hideControls: isModeTitle ? true : false,
      ),
    );
    if (isModeTitle) {
      addListenerYt();
    } else {
      handleSplitSub();
    }
  }

  void handleSplitSub() {
    for (var caption in captions.value) {
      paragraph.value += caption.content;
      listSubSplit.value.addAll(caption.content.split(' '));
    }
    paragraph.value =
        capitalizeFirstLetter(paragraph.value.split(' ').join(' '));
    blankIndexes.value = List.generate(
      10,
      (index) => generateRandomInt(1, listSubSplit.value.length),
    );

    blankIndexes.value
        .map((item) => print('log-data: blankIndexes : $item'))
        .toList();
  }

  void addListenerYt() {
    ytController.addListener(() {
      if (ytController.value.playerState == PlayerState.playing) {
        String duration = formatDuration(captions.value[0].start);
        String positon =
            formatMilliseconds(ytController.value.position.inMilliseconds);
        if (duration == positon) {
          debugPrint('compare: $duration - $positon');

          currentCaption.value =
              '${captions.value[0].start}: ${captions.value[0].content}';

          int selectedIndex = originCaptions.value.indexOf(captions.value[0]);

          scrollToIndex(selectedIndex);

          ItemCaptionModel itemCaptionModel = ItemCaptionModel(
              subtitleModel: originCaptions.value[selectedIndex],
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
  }

  Future<void> getCaptions(String videoId) async {
    captions.value.addAll(await VideoServices.instance.getCaptions(
      videoId: videoId,
    ));

    originCaptions.value = [...captions.value];
    listCaptionsShowing.value = originCaptions.value
        .map((item) => ItemCaptionModel(subtitleModel: item))
        .toList();
  }
}
