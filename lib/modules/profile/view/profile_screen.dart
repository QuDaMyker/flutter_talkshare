import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_talkshare/core/enums/role.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/profile/controller/profile_controller.dart';
import 'package:flutter_talkshare/modules/profile/widgets/circle_winner_widget.dart';
import 'package:flutter_talkshare/modules/profile/widgets/table_calendar_widget.dart';
import 'package:flutter_talkshare/modules/ranking/views/ranking_screen.dart';
import 'package:flutter_talkshare/modules/request_teacher/views/create_request_role_teacher_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  late AuthController authController;
  // ProfileController profileController = Get.find<ProfileController>();
  late ProfileController profileController;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    authController = Get.find<AuthController>();
    profileController = Get.put(ProfileController());
    super.initState();
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('didChangeAppLifecycleState');
    if (state == AppLifecycleState.resumed) {
      await authController.refreshUser();
    }
  }

  @override
  void didUpdateWidget(covariant ProfileScreen oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void activate() {
    print('activate');
    super.activate();
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void didChangeDependencies() async {
    await profileController.onRefreshProfile();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary80,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              _buildTopComponent(
                authController: authController,
                profileController: profileController,
              ),
              _buildMainBody(
                authController: authController,
                profileController: profileController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildMainBody({
    required AuthController authController,
    required ProfileController profileController,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          _buildStreakValue(profileController: profileController),
          const SizedBox(
            height: 20,
          ),
          TableCalendarWidget(
            start: DateTime.now().subtract(const Duration(days: 3)),
            end: DateTime.now().add(const Duration(days: 3)),
          ),
          const SizedBox(
            height: 20,
          ),
          // authController.user.role != Role.ROLE_STUDENT.toStringValue
          authController.user.role == Role.ROLE_STUDENT.toStringValue
              ? Column(
                  children: [
                    _buildButtonChangeRoleTeacher(onTap: () async {
                      final signal = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreateRequestRoleTeacherScreen(),
                        ),
                      );
                      print(signal);
                      if (signal['result'] == 'success') {
                        setState(() {});
                      }
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Align _buildButtonChangeRoleTeacher({required Function() onTap}) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.2, color: AppColors.gray20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Chuyển sang tài khoản giáo viên',
                  style: TextStyle(
                    color: AppColors.gray20,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildStreakValue({required ProfileController profileController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Streak',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                children: [
                  Obx(
                    () => Text(
                      profileController.streakCount.value.toString(),
                      style: TextStyle(
                        fontSize: 48,
                        color: AppColors.secondary20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    'Ngày Streak',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SvgPicture.asset(
                ImageAssets.icElectric,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Stack _buildTopComponent({
    required AuthController authController,
    required ProfileController profileController,
  }) {
    return Stack(
      //fit: StackFit.expand,
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.only(bottom: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                AppColors.primary40,
                AppColors.secondary40,
              ],
              stops: [0.6, 1],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _buildLabelUser(
              authController: authController,
              profileController: profileController,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabelUser({
    required AuthController authController,
    required ProfileController profileController,
  }) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 3,
            child: CircleWinnerWidget(
              colors: [
                AppColors.secondary20,
                Colors.white,
              ],
              size: Get.width * 0.5,
              thinness: 1,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: _buildAvatar(authController),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 7,
            child: _buildNameEmail(authController),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 4,
            child: _buildNavigateRank(
                ontap: () {
                  Get.to(() => RankingScreen());
                },
                profileController: profileController),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(AuthController authController) {
    return CircleAvatar(
      radius: 50,
      foregroundImage: CachedNetworkImageProvider(
        authController.user.avatar_url,
      ),
    );
  }

  Column _buildNameEmail(AuthController authController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            authController.user.fullname,
            style: const TextStyle(
              color: AppColors.primary40,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: authController.user.role == Role.ROLE_STUDENT.toStringValue
                ? AppColors.gray80
                : AppColors.primary40,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            authController.user.role == Role.ROLE_STUDENT.toStringValue
                ? 'Thành viên'
                : 'Giáo viên',
            style: TextStyle(
              color: authController.user.role == Role.ROLE_STUDENT.toStringValue
                  ? AppColors.gray20
                  : Colors.white,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigateRank({
    required Function() ontap,
    required ProfileController profileController,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.secondary20,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Điểm năng nổ',
                    style: TextStyle(
                      color: AppColors.gray20,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text(
                          profileController.sumPoint.value.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        ImageAssets.icElectric,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              ImageAssets.icRight,
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
