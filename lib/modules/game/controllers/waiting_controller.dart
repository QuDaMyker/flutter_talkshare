import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/game/view/playing_screen.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class WaitingController extends GetxController {
  final SupabaseService supabaseService = SupabaseService();
  StreamSubscription? roomSubscription;
  RxInt countdown = 3.obs;
  Timer? countdownTimer;
  String roomId = '';

  @override
  void onInit() {
    super.onInit();
    roomId = Get.arguments['roomId'] as String;
    bool isPlayer2 = Get.arguments['isPlayer2'] as bool;
    if (isPlayer2) {
      startCountdown(roomId, true);
    } else {
      waitForPlayer(roomId);
    }
  }

  void waitForPlayer(String roomId) {
    roomSubscription = supabaseService.onRoomJoined(roomId).listen((data) {
      if (data['player2_id'] != null) {
        startCountdown(roomId, false);
      }
    });
  }

  void startCountdown(String roomId, bool isPlayer2) {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value == 0) {
        timer.cancel();
        Get.back();
        Get.to(() => PlayingScreen(),
            arguments: {'roomId': roomId, 'isMyTurn': !isPlayer2});
        // ScaffoldMessenger.of(Get.context!).showSnackBar(
        //   SnackBar(
        //     content: const Text('Bat dau'),
        //   ),
        // );
      } else {
        countdown.value--;
      }
    });
  }

  @override
  void onClose() {
    roomSubscription?.cancel();
    countdownTimer?.cancel();
    super.onClose();
  }
}
