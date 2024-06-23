import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/game/view/waiting_screen.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  UserModel? currentUser;
  var supabaseService = SupabaseService.instance;
  TextEditingController roomCodeCtrl = TextEditingController();
  RxInt wins = 0.obs;
  RxInt losses = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    currentUser = authController.user;
    updateStat();
  }

  void updateStat() async {
    final stats =
        await supabaseService.getUserWinsAndLosses(currentUser?.user_id ?? '');
    wins.value = stats['wins'] ?? 0;
    losses.value = stats['losses'] ?? 0;
    print(losses.value.toString() + "==============");
  }

  void onPlayRandom() async {
    final room = await supabaseService.findWaitingRoom();

    if (room != null) {
      await supabaseService.joinRoom(room['id'], currentUser?.user_id ?? '');
      Get.to(() => WaitingScreen(),
              arguments: {'roomId': room['id'], 'isPlayer2': true, 'code': ''})
          ?.then((value) => updateStat());
    } else {
      final newRoom = await supabaseService
          .createRoom(currentUser?.user_id ?? '', isRandom: true);
      Get.to(() => WaitingScreen(), arguments: {
        'roomId': newRoom['id'],
        'isPlayer2': false,
        'code': ''
      })?.then((value) => updateStat());
    }
  }

  void onCreateRoom() async {
    if (roomCodeCtrl.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng nhập mã phòng'),
        ),
      );
      return;
    }
    final newRoom = await supabaseService.createRoom(currentUser?.user_id ?? '',
        isRandom: false, code: roomCodeCtrl.text);
    if (newRoom['id'] != null) {
      Get.to(() => WaitingScreen(), arguments: {
        'roomId': newRoom['id'],
        'isPlayer2': false,
        'code': roomCodeCtrl.text
      })?.then((value) => updateStat());
    }
  }

  void onJoinRoomWithCode() async {
    final roomId = await supabaseService.getRoomIdByCode(roomCodeCtrl.text);

    if (roomId != null) {
      await supabaseService.joinRoom(roomId, currentUser?.user_id ?? '');
      Get.to(() => WaitingScreen(),
              arguments: {'roomId': roomId, 'isPlayer2': true, 'code': ''})
          ?.then((value) => updateStat());
    } else {
      print('Không tồn tại phòng');
    }
  }
}
