import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/enums/community_tab.dart';
import 'package:flutter_talkshare/core/models/audio_room.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CommunityController extends GetxController
    with GetTickerProviderStateMixin {
  var selectedTab = CommunityTab.INTERACTION.obs;
  late Animation<double> animation;
  late AnimationController animationController;
  var speakerNum = 4.obs;
  var isPrivateRoom = false.obs;
  TextEditingController roomNameCtrl = TextEditingController();
  TextEditingController roomTopicCtrl = TextEditingController();
  TextEditingController passcodeCtrl = TextEditingController();
  RxList<AudioRoom> listRoom = RxList.empty();
  TextEditingController confirmPasscodeCtrl = TextEditingController();

  @override
  void onInit() async {
    var list = await SupabaseService.instance.getAllAudioRoom();
    listRoom.addAll(list);

    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.onInit();
  }

  void creatRoom(String roomId) {
    AudioRoom audioRoom = AudioRoom(
        roomId: roomId,
        name: roomNameCtrl.text,
        topic: roomTopicCtrl.text,
        quantity: speakerNum.value,
        userId: 'f6ee03f6-55a3-4d03-9cd2-3a3e0450e352',
        passcode: isPrivateRoom.value ? int.parse(passcodeCtrl.text) : null,
        createdAt: DateTime.now().toUtc().millisecondsSinceEpoch,
        isActive: true);
    SupabaseService.instance.insertRoom(audioRoom);
  }
}
