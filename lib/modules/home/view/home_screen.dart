import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Text(
          'HomeScreen',
          style: TextStyle(
            fontSize: deviceWidth * 0.05,
          ),
        ),
      ),
    );
  }
}
