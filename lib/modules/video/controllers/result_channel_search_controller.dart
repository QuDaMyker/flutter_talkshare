import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:get/get.dart';

class ResultChannelSearchController extends GetxController {
  var videos = Rx<List<VideoModel>>([]);
  var isLoading = Rx<bool>(false);

  @override
  void onInit() async {
    isLoading.value = true;

    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListChannel(int limit) async {}
}
