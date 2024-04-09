import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:get/get.dart';

class VideoDashBoardController extends GetxController {
  var searchValue = Rx<String>('');
  var popularVideos = Rx<List<VideoModel>>([]);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
