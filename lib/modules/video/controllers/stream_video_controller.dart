import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/video/models/caption_response.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:youtube_caption_scraper/youtube_caption_scraper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamVideoController extends GetxController {
  final VideoModel videoModel;
  StreamVideoController({required this.videoModel});

  var isLoading = Rx<bool>(true);
  var captions = Rx<List<CaptionResponse>>([]);
  var originCaptions = Rx<List<CaptionResponse>>([]);
  var currentCaption = Rx<String>('');
  late YoutubeExplode yt;
  late Video video;
  late YoutubePlayerController ytController;

  @override
  void onInit() async {
    yt = YoutubeExplode();
    await fetchVideoInfo();
    initYtController();
    await getCaptions(video.id.toString());
    isLoading.value = false;

    super.onInit();
  }

  @override
  void onClose() {
    yt.close();
    super.onClose();
  }

  Future<void> fetchVideoInfo() async {
    var videoId = VideoId('https://youtu.be/_uUskajC1Ps?si=qTao3UmyAtreZBg0');
    video = await yt.videos.get(videoId);
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
    ytController.addListener(() {
      ytController.addListener(() {
        if (ytController.value.playerState == PlayerState.playing) {
          // ignore: unrelated_type_equality_checks
          /* if (ytController.value.position.toString() == '0:00:04.417') {
            Get.snackbar(
                'title',
                captions.value
                    .firstWhere((element) => element.start == 4.417)
                    .text!);
          }
          print(
              'Current position: inMilliseconds ${ytController.value.position.inMilliseconds}');
          print(
              'Current position: inSeconds ${ytController.value.position.inSeconds}');
          print(
              'Current position: inMicroseconds ${ytController.value.position.inMicroseconds}');
          print(
              'Current position: inMilliseconds ${ytController.value.position.inMinutes}'); */

          /* CaptionResponse captionResponse = captions.value.firstWhere(
            (element) {
              String duration = formatDuration(element.start as double);
              String positon = formatMilliseconds(
                  ytController.value.position.inMilliseconds);
              if (duration == positon) {
                debugPrint('compare: $duration - $positon');
              }

              return duration == positon;
            },
            orElse: () => CaptionResponse(
                index: -1, start: 1, dur: 1, end: 1, text: 'text'),
          );
          if (captionResponse.index != -1) {
            captions.value = [...captions.value.sublist(1)];
            currentCaption.value = captionResponse.text!;
          } */
          String duration = formatDuration(captions.value[0].start as double);
          String positon =
              formatMilliseconds(ytController.value.position.inMilliseconds);
          if (duration == positon) {
            debugPrint('compare: $duration - $positon');
            currentCaption.value =
                '${captions.value[0].start!}: ${captions.value[0].text!}';
            captions.value = [...captions.value.sublist(1)];
          }
        }
      });
    });
  }

  void getSubtitle() async {
    final captionScraper = YouTubeCaptionScraper();

    final captionTracks = await captionScraper.getCaptionTracks(
        'https://www.youtube.com/watch?v=Kt8tyZRRh2I&ab_channel=Th%E1%BA%A7yGi%C3%A1oBa');

    debugPrint('subtitle: ${captionTracks.length.toString()}');
    final subtitles = await captionScraper.getSubtitles(captionTracks[0]);

    isLoading.value = false;
  }

  Future<void> getCaptions(String videoId) async {
    var headers = {
      'X-RapidAPI-Key': '5b9d212c25msh6131ec65d45038bp1252f0jsn68d667b446d8',
      'X-RapidAPI-Host': 'subtitles-for-youtube.p.rapidapi.com'
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
    } else {
      debugPrint('response.statusMessage: ${response.statusMessage}');
    }
  }
}
