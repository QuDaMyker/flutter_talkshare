import 'package:flutter/material.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class PlayingController extends GetxController {
  var supabaseService = SupabaseService.instance;

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final TextEditingController textController = TextEditingController();
  String roomId = '';

  @override
  void onInit() {
    super.onInit();
    roomId = Get.arguments['roomId'] as String;

    listenForMessages();
  }

  void sendMessage(String userId) async {
    if (textController.text.trim().isNotEmpty) {
      await supabaseService.sendMessage(
          roomId, userId, textController.text.trim());
      textController.clear();
    }
  }

  void listenForMessages() {
    supabaseService.onReceiveMessage(roomId).listen((message) {
      messages.add(message);
    });
  }
}
