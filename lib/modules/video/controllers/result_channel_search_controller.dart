import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:get/get.dart';

class ResultChannelSearchController extends GetxController {
  var videos = Rx<List<VideoModel>>([]);
  var isLoading = Rx<bool>(false);
}
