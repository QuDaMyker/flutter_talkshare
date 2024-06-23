import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/community/view/community_screen.dart';
import 'package:flutter_talkshare/modules/game/view/game_screen.dart';
import 'package:flutter_talkshare/modules/home/view/home_screen.dart';
import 'package:flutter_talkshare/modules/profile/services/point_learning_services.dart';
import 'package:flutter_talkshare/modules/profile/view/profile_screen.dart';
import 'package:flutter_talkshare/utils/helper.dart';
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
  void onInit() async {
    Get.lazyPut(() => HomeScreen());
    Get.lazyPut(() => CommnityScreen());
    // Get.lazyPut(() => const HomeworkScreen());
    Get.lazyPut(() => const GameScreen());
    Get.lazyPut(() => const ProfileScreen());

    pageController = PageController(initialPage: 0);
    await checkStreak();
    super.onInit();
  }

  Future<void> checkStreak() async {
    final AuthController authController = Get.find<AuthController>();
    String today = Helper.instance.formatDateTimeToYyyyMmDd(DateTime.now());
    int? count = await PointLearningServices.instance.getCountDate(
      today: today,
      user_id: authController.user.user_id,
    );
    print('count: $count');
    if (count == 0) {
      await PointLearningServices.instance.addStreak(
        user_id: authController.user.user_id,
        today: today,
      );
    }
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
