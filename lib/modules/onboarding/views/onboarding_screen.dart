import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/configuration/injection.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/constants.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/views/login_screen.dart';
import 'package:flutter_talkshare/modules/home/view/home_screen.dart';
import 'package:flutter_talkshare/modules/onboarding/controller/onboarding_controller.dart';
import 'package:flutter_talkshare/modules/root_view/view/root_view_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnBoardingController controller = Get.put(OnBoardingController());
  @override
  void initState() {
    super.initState();
    controller.pagesController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    controller.pagesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildPageView(),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,
              right: MediaQuery.of(context).size.width * 0.04,
              child: Obx(
                () => _buildButtonIgnore(),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              right: MediaQuery.of(context).size.width * 0.04,
              child: Obx(
                () => _buildButtonNext(),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Obx(
                () => _buildIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PageView _buildPageView() {
    return PageView.builder(
      onPageChanged: (index) {
        controller.currentPage.value = index;
        if (index == controller.listOnBoarding.length - 1) {
          controller.isFinalPage.value = true;
        } else {
          controller.isFinalPage.value = false;
        }
      },
      itemCount: controller.listOnBoarding.length,
      controller: controller.pagesController,
      itemBuilder: (context, index) => controller.listOnBoarding[index],
    );
  }

  Container _buildButtonIgnore() {
    return Container(
      child: !controller.isFinalPage.value
          ? TextButton(
              onPressed: () {
                controller.pagesController.jumpTo(
                    controller.pagesController.position.maxScrollExtent);
              },
              child: const Text(
                'Bỏ qua',
                style: TextStyle(
                  color: AppColors.gray20,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  GestureDetector _buildButtonNext() {
    return GestureDetector(
      onTap: () async {
        if (controller.isFinalPage.value) {
          var sharePrefernces = await getIt<SharedPreferences>();
          sharePrefernces.getString(Constants.USER_STRING) != null
              ? Get.offAll(
                  () => RootViewScreen(),
                  transition: Transition.rightToLeftWithFade,
                )
              : Get.off(
                  () => const LoginScreen(),
                  transition: Transition.rightToLeftWithFade,
                );
        } else {
          controller.pagesController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.secondary20,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            //horizontal: 20,
            vertical: 10,
          ),
          child: Text(
            controller.isFinalPage.value ? 'Bắt đầu' : 'Tiếp tục',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  AnimatedSmoothIndicator _buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: controller.currentPage.value,
      count: controller.listOnBoarding.length,
      effect: const WormEffect(
        activeDotColor: AppColors.primary40,
        dotHeight: 5.0,
        radius: 30,
        spacing: 2,
        type: WormType.thin,
        strokeWidth: 3,
      ),
    );
  }
}
