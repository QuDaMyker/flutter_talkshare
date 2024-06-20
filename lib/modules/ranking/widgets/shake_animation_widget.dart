import 'package:flutter/material.dart';

class ShakeAnimationWidget extends StatefulWidget {
  const ShakeAnimationWidget({
    super.key,
    required this.child,
    required this.begin,
    required this.end,
  });

  final Widget child;
  final double begin;
  final double end;
  @override
  State<StatefulWidget> createState() => _ShakeAnimationWidgetState();
}

class _ShakeAnimationWidgetState extends State<ShakeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation =
        Tween(begin: widget.begin, end: widget.end)
            .chain(
              CurveTween(curve: Curves.elasticIn),
            )
            .animate(controller);
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse();
    //   }
    // });

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (buildContext, child) {
        // if (offsetAnimation.value < 0.0)
        //   print('${offsetAnimation.value + 8.0}');
        return Container(
          margin: EdgeInsets.symmetric(horizontal: widget.end),
          padding: EdgeInsets.only(
            left: offsetAnimation.value + widget.end,
            right: widget.end - offsetAnimation.value,
          ),
          child: Center(
            child: widget.child,
          ),
        );
      },
    );
  }
}
