import 'package:flutter/material.dart';

class ItemPageView extends StatelessWidget {
  const ItemPageView({
    super.key,
    required this.pageController,
    required this.title,
    required this.index,
  });

  final PageController pageController;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(5),
        width: deviceWidth * 0.25,
        height: deviceHeight * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: null,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xffb7b9b8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
