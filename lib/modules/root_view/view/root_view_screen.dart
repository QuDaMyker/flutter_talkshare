import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/root_view/controller/root_view_controller.dart';
import 'package:get/get.dart';

class RootViewScreen extends StatelessWidget {
  const RootViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rootViewController = Get.put(RootViewController(), permanent: true);
    return SafeArea(
        child: Scaffold(
      body: PageView(
        onPageChanged: rootViewController.animateToTab,
        controller: rootViewController.pageController,
        // physics: const NeverScrollableScrollPhysics(),
        children: rootViewController.screens,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: rootViewController.currentPage.value,
          onTap: (value) {
            rootViewController.onChangePage(value);
          },
          selectedItemColor: AppColors.primary40,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people_outline,
              ),
              label: 'Cộng đồng',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books_outlined,
              ),
              label: 'Bài tập',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.videogame_asset_outlined,
              ),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: 'Tài khoản',
            ),
          ],
        ),
      ),
    ));
  }
}
