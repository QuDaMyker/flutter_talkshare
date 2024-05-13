import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Comming Soon',
          style: TextStyle(
            color: AppColors.primary20,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
