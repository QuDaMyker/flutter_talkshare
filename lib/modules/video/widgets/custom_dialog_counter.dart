import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomDialogCounter extends StatelessWidget {
  const CustomDialogCounter({
    super.key,
    required this.firstString,
    required this.secondString,
    required this.onClick,
  });
  final String firstString;
  final String secondString;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: deviceHeight / 2,
          maxWidth: deviceWidth * 0.9,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAnimation(),
            const SizedBox(
              height: 20,
            ),
            Text(
              firstString,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              secondString,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            _buildButton(deviceHeight, deviceWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(double deviceHeight, double deviceWidth) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.012,
          horizontal: deviceWidth * 0.1,
        ),
        margin: EdgeInsets.only(
          left: deviceWidth * 0.1,
          right: deviceWidth * 0.1,
          bottom: 40,
        ),
        decoration: const BoxDecoration(
          color: AppColors.secondary20,
          border: Border(
            top: BorderSide(color: Colors.transparent, width: 0),
            bottom: BorderSide(color: Colors.transparent, width: 0),
            right: BorderSide(color: Colors.transparent, width: 0),
            left: BorderSide(color: Colors.transparent, width: 0),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: const Text(
          'Học tiếp',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Stack _buildAnimation() {
    return Stack(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: CircleAvatar(
            child: Lottie.asset(
                'assets/images/lottie/ic_text_congratulation.json'),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Lottie.asset(
              'assets/images/lottie/ic_effect_congratulation.json'),
        ),
      ],
    );
  }
}
