import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/game/view/waiting_screen.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  UserModel? currentUser;
  var supabaseService = SupabaseService.instance;

  @override
  void onInit() {
    super.onInit();
    currentUser = authController.user;
  }

  void onPlayRandom() async {
    final room = await supabaseService.findWaitingRoom();

    if (room != null) {
      await supabaseService.joinRoom(room['id'], 'f6ee03f6-55a3-4d03-9cd2-3a3e0450e352');
      Get.to(() => WaitingScreen(), arguments: {'roomId': room['id'], 'isPlayer2': true});
    } else {
      final newRoom =
          await supabaseService.createRoom('f6ee03f6-55a3-4d03-9cd2-3a3e0450e352');
      Get.to(() => WaitingScreen(), arguments: {'roomId': newRoom['id'], 'isPlayer2': false});
    }
  }
}
