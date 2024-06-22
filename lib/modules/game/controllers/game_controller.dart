import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/game/view/waiting_screen.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  UserModel? currentUser;
  var supabaseService = SupabaseService.instance;
  TextEditingController friendIdCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    currentUser = authController.user;
  }

  void onPlayRandom() async {
    final room = await supabaseService.findWaitingRoom();

    if (room != null) {
      await supabaseService.joinRoom(room['id'], currentUser?.user_id ?? '');
      Get.to(() => WaitingScreen(),
          arguments: {'roomId': room['id'], 'isPlayer2': true});
    } else {
      final newRoom = await supabaseService
          .createRoom(currentUser?.user_id ?? '', isRandom: true);
      Get.to(() => WaitingScreen(),
          arguments: {'roomId': newRoom['id'], 'isPlayer2': false});
    }
      }

  void onInviteFriend() async {
    final newRoom = await supabaseService.createRoom(currentUser?.user_id ?? '',
        isRandom: false);
    Get.to(() => WaitingScreen(),
        arguments: {'roomId': newRoom['id'], 'isPlayer2': false});
    supabaseService.sendInvitation(
        currentUser?.user_id ?? '', friendIdCtrl.text, newRoom['id']);
  }
}
