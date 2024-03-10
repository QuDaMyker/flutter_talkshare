import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/root_view/controller/root_view_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class RootViewScreen extends StatefulWidget {
  const RootViewScreen({super.key});

  @override
  State<RootViewScreen> createState() => _RootViewScreenState();
}

class _RootViewScreenState extends State<RootViewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            () => ResponsiveNavigationBar(
              selectedIndex: rootViewController.currentPage.value,
              onTabChange: (value) {
                rootViewController.onChangePage(value);
              },
              // showActiveButtonText: false,
              backgroundColor: Colors.transparent,
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              navigationBarButtons: const <NavigationBarButton>[
                NavigationBarButton(
                  text: 'Trang chủ',
                  icon: Icons.home_outlined,
                  backgroundGradient: LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                ),
                NavigationBarButton(
                  text: 'Cộng đồng',
                  icon: Icons.people_outline,
                  backgroundGradient: LinearGradient(
                    colors: [Colors.cyan, Colors.teal],
                  ),
                ),
                NavigationBarButton(
                  text: 'Bài tập',
                  icon: Icons.library_books_outlined,
                  backgroundGradient: LinearGradient(
                    colors: [Colors.green, Colors.yellow],
                  ),
                ),
                NavigationBarButton(
                  text: 'Game',
                  icon: Icons.videogame_asset_outlined,
                  backgroundGradient: LinearGradient(
                    colors: [Colors.green, Colors.yellow],
                  ),
                ),
                NavigationBarButton(
                  text: 'Tài khoản',
                  icon: Icons.person_2_outlined,
                  backgroundGradient: LinearGradient(
                    colors: [Colors.green, Colors.yellow],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
