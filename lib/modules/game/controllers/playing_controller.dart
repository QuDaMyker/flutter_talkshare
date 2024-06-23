import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/core/values/word_list.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:isitaword/isitaword.dart';

class PlayingController extends GetxController {
  var supabaseService = SupabaseService.instance;
  final AuthController authController = Get.find<AuthController>();
  UserModel? currentUser;
  UserModel? peerUser;

  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  final TextEditingController textController = TextEditingController();
  String roomId = '';
  StreamSubscription? roomSubscription;
  RxBool isMyTurn = false.obs;
  RxInt remainingSeconds = 0.obs;
  Timer? _timer;
  RxInt myScore = 0.obs;
  RxInt peerScore = 0.obs;
  RxString lastMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    roomId = Get.arguments['roomId'] as String;
    peerUser = Get.arguments['peerUser'] as UserModel?;
    currentUser = authController.user;

    bool myTurn = Get.arguments['isMyTurn'] as bool;
    if (myTurn) {
      startTurn();
    }

    listenForMessages();
  }

  @override
  void onClose() {
    roomSubscription?.cancel();
    _timer?.cancel();
    super.onClose();
  }

  void sendMessage() async {
    if (textController.text == " " ||
        WordList.en.contains(textController.text.trim().toLowerCase())) {
      await supabaseService.sendMessage(
          roomId,
          currentUser?.user_id ?? '',
          textController.text == ' '
              ? textController.text
              : textController.text.trim());
      textController.clear();
      endTurn();
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: const Text('Vui lòng nhập từ vựng tiếng Anh'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  void listenForMessages() {
    roomSubscription =
        supabaseService.onReceiveMessage(roomId).listen((message) {
      messages.insert(0, message);
      if (message['word'].toString().trim().length > 0) {
        lastMessage.value = message['word'];
      }
      if (message['user_id'] != currentUser?.user_id) {
        startTurn();
        peerScore.value += message['word'].toString().trim().length;
        if (peerScore.value >= 20) {
          endRoom(message['user_id']);
        }
      } else {
        myScore.value += message['word'].toString().trim().length;
        if (myScore.value >= 20) {
          endRoom(message['user_id']);
        }
      }
    });
  }

  void startTurn() {
    isMyTurn.value = true;
    remainingSeconds.value = 15;
    if (lastMessage.value.isNotEmpty) {
      String initialCharacter = lastMessage.value[lastMessage.value.length - 1];
      textController.text = initialCharacter;
    }
    _startTimer();
  }

  void endTurn() {
    isMyTurn.value = false;
    _timer?.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        endTurn();
        textController.text = ' ';
        sendMessage();
      }
    });
  }

  Future<void> endRoom(String winnerId) async {
    await supabaseService.endGame(roomId, winnerId);
    _timer?.cancel();
    UserModel? winner =
        winnerId == currentUser?.user_id ? currentUser : peerUser;
    showModalBottomSheet(
        isScrollControlled: true,
        context: Get.context!,
        builder: (context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        ImageAssets.bgWinner,
                        width: Get.width - 100,
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Người chiến thắng',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary20),
                              ),
                              SizedBox(height: 12),
                              CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    winner != null ? winner.avatar_url : 'https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg'),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(height: 8),
                              Text(
                                winner != null ? winner.fullname : '',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondary20),
                              ),
                            ],
                          ))
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      Get.back();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.secondary20,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
