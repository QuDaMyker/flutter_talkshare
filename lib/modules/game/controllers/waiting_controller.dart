import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/game/view/playing_screen.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class WaitingController extends GetxController {
  final SupabaseService supabaseService = SupabaseService();
  StreamSubscription? roomSubscription;
  RxInt countdown = 4.obs;
  Timer? countdownTimer;
  String roomId = '';
  bool isPlayer2 = false;
  Rx<String> roomCode = ''.obs;

  final AuthController authController = Get.find<AuthController>();
  UserModel? currentUser;
  Rx<UserModel?> peerUser = Rx(null);

  @override
  void onInit() async {
    super.onInit();
    roomId = Get.arguments['roomId'] as String;
    isPlayer2 = Get.arguments['isPlayer2'] as bool;
    currentUser = authController.user;
    roomCode.value = Get.arguments['code'] as String;

    if (isPlayer2) {
      startCountdown(roomId, true);
      peerUser.value = await supabaseService.getUserById(
          await supabaseService.getPlayerIdByRoomId(roomId, isPlayer2) ?? '');
    } else {
      waitForPlayer(roomId);
    }
  }

  void waitForPlayer(String roomId) {
    roomSubscription =
        supabaseService.onRoomJoined(roomId).listen((data) async {
      if (data['player2_id'] != null) {
        startCountdown(roomId, false);
        peerUser.value = await supabaseService.getUserById(
            await supabaseService.getPlayerIdByRoomId(roomId, isPlayer2) ?? '');
      }
    });
  }

  Future<void> endRoom() async {
    await supabaseService.endGame(roomId, null);
  }

  void startCountdown(String roomId, bool isPlayer2) {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value == 0) {
        timer.cancel();
        Get.back();
        Get.to(() => PlayingScreen(), arguments: {
          'roomId': roomId,
          'isMyTurn': !isPlayer2,
          'peerUser': peerUser.value
        });
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
