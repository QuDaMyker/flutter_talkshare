import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/community/view/community_screen.dart';
import 'package:flutter_talkshare/modules/game/view/game_screen.dart';
import 'package:flutter_talkshare/modules/home/view/home_screen.dart';
import 'package:flutter_talkshare/modules/profile/view/profile_screen.dart';
import 'package:get/get.dart';

class RootViewController extends GetxController {
  late PageController pageController;
  var currentPage = Rx<int>(0);
  var isRead = Rx<bool>(false);
  var isReadList = Rx<List<String>>([]);
  final text = TextEditingController();

  final screens = [
    HomeScreen(),
    CommnityScreen(),
    GameScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    Get.lazyPut(() => HomeScreen());
    Get.lazyPut(() => CommnityScreen());
    // Get.lazyPut(() => const HomeworkScreen());
    Get.lazyPut(() => GameScreen());
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
