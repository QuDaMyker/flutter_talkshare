import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/constants.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/splash/controller/splash_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(ImageAssets.icSplash),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Talk Share',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary40,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ứng dụng học tiếng anh cho người Việt 🇻🇳/🏴󠁧󠁢󠁥󠁮󠁧󠁿',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary40,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: LoadingAnimationWidget.discreteCircle(
                  secondRingColor: AppColors.secondary20,
                  thirdRingColor: AppColors.gray40,
                  color: AppColors.primary40,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
