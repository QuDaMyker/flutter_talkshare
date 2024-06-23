import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/onboarding/widgets/chose_agent_onboarding.dart';
import 'package:flutter_talkshare/modules/onboarding/widgets/chose_level_onboarding.dart';
import 'package:flutter_talkshare/modules/onboarding/widgets/chose_target_onboarding.dart';
import 'package:flutter_talkshare/modules/onboarding/widgets/first_onboarding.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  late PageController pagesController;
  RxInt currentPage = 0.obs;
  RxBool isFinalPage = false.obs;
  var selectedLevel = Rx<int>(0);
  var selectedTarget = Rx<int>(0);
  var selectedAgent = Rx<int>(0);

  @override
  void onInit() {
    super.onInit();
  }

  void onSelectedAgent(int level) {
    selectedAgent.value = level;
    debugPrint('selectedAgent: ${selectedAgent.value}');
  }

  void onSelectedLevel(int level) {
    selectedLevel.value = level;
    debugPrint('selectedLevel: ${selectedLevel.value}');
  }

  void onSelectedTarget(int level) {
    selectedTarget.value = level;
    debugPrint('selectedTarget: ${selectedTarget.value}');
  }

  List<Widget> listOnBoarding = [
    const FirstOnBoarding(
      image: ImageAssets.icSplash,
      title: 'Chào mừng bạn đến với ứng dụng',
      subTitle: 'Talk Share',
      description:
          'Nền tảng tuyệt vời đem đến trải nghiệm đầy sáng tạo, giúp bạn rèn luyện tiếng Anh với cộng đồng trò chuyện sôi động!',
    ),
    ChoseLevelBoarding(
      title: 'Chọn trình độ hiện tại của bạn',
      levels: [
        {
          'id': 0,
          'icon': ImageAssets.icRedStar,
          // 'icon': ImageAssets.icAgentAnhle,
          'title': 'Mới bắt đầu',
        },
        {
          'id': 1,
          'icon': ImageAssets.icOrangeStar,
          'title': 'Trung bình',
        },
        {
          'id': 2,
          'icon': ImageAssets.icYellowStar,
          'title': 'Khá',
        },
        {
          'id': 3,
          'icon': ImageAssets.icGreenStar,
          'title': 'Giỏi',
        },
        {
          'id': 4,
          'icon': ImageAssets.icGreenLightStar,
          'title': 'Xuất sắc',
        },
      ],
      onSelect: (p0) {},
    ),
    ChoseTargetBoarding(
      title: 'Mục tiêu học tiếng Anh của bạn',
      levels: [
        {
          'id': 0,
          'icon': '',
          'title': 'Giao tiếp',
        },
        {
          'id': 1,
          'icon': '',
          'title': 'Chuyên ngành',
        },
        {
          'id': 2,
          'icon': '',
          'title': 'THCS, THPT & thi đại học',
        },
        {
          'id': 3,
          'icon': '',
          'title': 'Chứng chỉ',
        },
        {
          'id': 4,
          'icon': '',
          'title': 'Khác',
        },
      ],
      onSelect: (p0) {},
    ),
    ChoseAgentBoarding(
      title: 'Bạn quan tâm trung tâm tiếng Anh nào?',
      levels: [
        {
          'id': 0,
          'icon': ImageAssets.icAgentEquest,
        },
        {
          'id': 1,
          'icon': ImageAssets.icAgentIla,
        },
        {
          'id': 2,
          'icon': ImageAssets.icAgentLangmaster,
        },
        {
          'id': 3,
          'icon': ImageAssets.icAgentApollo,
        },
        {
          'id': 4,
          'icon': ImageAssets.icAgentAnhle,
        },
        {
          'id': 5,
          'icon': ImageAssets.icAgentIeltsFighter,
        },
        {
          'id': 6,
          'icon': ImageAssets.icAgentVus,
        },
      ],
      onSelect: (p0) {},
    ),
  ];
}
