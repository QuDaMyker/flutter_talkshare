import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/enums/community_tab.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController
    with GetTickerProviderStateMixin {
  var selectedTab = CommunityTab.INTERACTION.obs;
  late Animation<double> animation;
  late AnimationController animationController;
  var speakerNum = 4.obs;
  var isPrivateRoom = false.obs;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.onInit();
  }
}
