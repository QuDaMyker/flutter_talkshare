import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/video/models/channel_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class VideoDashBoardController extends GetxController {
  var searchValue = Rx<String>('');
  var popularVideos = Rx<List<VideoModel>>([]);
  var channels = Rx<List<ChannelModel>>([]);
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
    super.onClose();
  }

  Future<void> getListChannel(int limit) async {
    try {
      channels.value = await SupabaseService.instance.getListChannel(limit);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getListPopular(int limit) async {
    try {
      await SupabaseService.instance.getListVideo(limit);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
