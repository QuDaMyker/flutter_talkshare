import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class FirstOnBoarding extends StatelessWidget {
  final String image, title, subTitle, description;
  const FirstOnBoarding({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.subTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 40,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset(
            image,
            height: 250,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.secondary20,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          subTitle != ''
              ? Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.primary40,
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 8,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.primary20,
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
