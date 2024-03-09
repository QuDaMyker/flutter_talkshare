import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/community/view/community_screen.dart';
import 'package:flutter_talkshare/modules/game/view/game_screen.dart';
import 'package:flutter_talkshare/modules/home/view/home_screen.dart';
import 'package:flutter_talkshare/modules/homework/view/homework_screen.dart';
import 'package:flutter_talkshare/modules/profile/view/profile_screen.dart';
import 'package:get/get.dart';

class RootViewController extends GetxController {
  late PageController pageController;
  var currentPage = Rx<int>(0);
  final screens = const [
    HomeScreen(),
    CommnityScreen(),
    HomeworkScreen(),
    GameScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    Get.lazyPut(() => const HomeScreen());
    Get.lazyPut(() => const CommnityScreen());
    Get.lazyPut(() => const HomeworkScreen());
    Get.lazyPut(() => const GameScreen());
    Get.lazyPut(() => const ProfileScreen());

    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onChangePage(int index) {
    currentPage.value = index;
    pageController.jumpToPage(index);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}
