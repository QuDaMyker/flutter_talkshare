import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:get/get.dart';
import 'package:youtube_caption_scraper/youtube_caption_scraper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamVideoController extends GetxController {
  final VideoModel videoModel;
  StreamVideoController({required this.videoModel});

  var isLoading = Rx<bool>(true);
  late YoutubeExplode yt;
  late Video video;
  late YoutubePlayerController ytController;
  @override
  void onInit() async {
    yt = YoutubeExplode();
    await fetchVideoInfo();
    initYtController();
    getSubtitle();

    super.onInit();
  }

  @override
  void onClose() {
    yt.close();
    super.onClose();
  }

  Future<void> fetchVideoInfo() async {
    var videoId = VideoId(
        'https://www.youtube.com/watch?v=Kt8tyZRRh2I&ab_channel=Th%E1%BA%A7yGi%C3%A1oBa');
    video = await yt.videos.get(videoId);
  }

  void initYtController() {
    ytController = YoutubePlayerController(
      initialVideoId: video.id.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  void getSubtitle() async {
    final captionScraper = YouTubeCaptionScraper();

    final captionTracks = await captionScraper.getCaptionTracks(
        'https://www.youtube.com/watch?v=Kt8tyZRRh2I&ab_channel=Th%E1%BA%A7yGi%C3%A1oBa');

    debugPrint('subtitle: ${captionTracks.length.toString()}');
    final subtitles = await captionScraper.getSubtitles(captionTracks[0]);

    for (final subtitle in subtitles) {
      print(
          'subtitle: ${subtitle.start} - ${subtitle.duration} - ${subtitle.text}');
    }

    isLoading.value = false;
  }
}
