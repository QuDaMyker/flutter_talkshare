import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:lottie/lottie.dart';

class CustomAuthDialog extends StatelessWidget {
  const CustomAuthDialog({
    super.key,
    required this.titleButton,
    required this.pathLottie,
    required this.pathBackgroundLottie,
    required this.onTap,
  });

  final String titleButton;
  final String pathBackgroundLottie;
  final String pathLottie;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: AppColors.secondary20,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                    child: Lottie.asset(pathLottie),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Lottie.asset(pathLottie),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              titleButton,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary20,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Đồng ý',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
