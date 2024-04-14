import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/root_view/controller/root_view_controller.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../core/values/image_assets.dart';

class RootViewScreen extends StatelessWidget {
  const RootViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rootViewController = Get.put(RootViewController(), permanent: true);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          body: PageView(
            onPageChanged: rootViewController.animateToTab,
            controller: rootViewController.pageController,
            // physics: const NeverScrollableScrollPhysics(),
            children: rootViewController.screens,
          ),
          bottomNavigationBar: Obx(
            () => SalomonBottomBar(
              currentIndex: rootViewController.currentPage.value,
              onTap: (value) {
                rootViewController.onChangePage(value);
              },
              items: [
                SalomonBottomBarItem(
                    icon: SvgPicture.asset(ImageAssets.icHome),
                    title: const Text("Trang chủ"),
                    selectedColor: AppColors.primary40,
                    activeIcon: SvgPicture.asset(ImageAssets.icHomeFill)),
                SalomonBottomBarItem(
                    icon: SvgPicture.asset(ImageAssets.icCommunity),
                    title: const Text("Cộng đồng"),
                    selectedColor: AppColors.primary40,
                    activeIcon: SvgPicture.asset(ImageAssets.icCommunityFill)),
                // SalomonBottomBarItem(
                //     icon: SvgPicture.asset(
                //       ImageAssets.icEditThin,
                //       color: AppColors.gray20,
                //     ),
                //     title: const Text("Bài tập"),
                //     selectedColor: AppColors.primary40,
                //     activeIcon: SvgPicture.asset(ImageAssets.icEditFill)),
                SalomonBottomBarItem(
                    icon: SvgPicture.asset(ImageAssets.icGame),
                    title: const Text("Game"),
                    selectedColor: AppColors.primary40,
                    activeIcon: SvgPicture.asset(ImageAssets.icGameFill)),
                SalomonBottomBarItem(
                    icon: SvgPicture.asset(ImageAssets.icAccount),
                    title: const Text("Tài khoản"),
                    selectedColor: AppColors.primary40,
                    activeIcon: SvgPicture.asset(ImageAssets.icAccountFill)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
