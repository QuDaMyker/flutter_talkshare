import 'package:flutter/material.dart';

class CircleWinnerWidget extends StatefulWidget {
  const CircleWinnerWidget({
    super.key,
    required this.colors,
    required this.size,
    required this.thinness,
    required this.child,
  });

  final List<Color> colors;
  final double size;
  final double thinness;
  final Widget child;
  @override
  State<CircleWinnerWidget> createState() => _CircleWinnerWidgetState();
}

class _CircleWinnerWidgetState extends State<CircleWinnerWidget>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _widget) {
              return Transform.rotate(
                angle: animationController.value * 6.3,
                child: _widget,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: widget.colors,
                  stops: [
                    0.2,
                    1,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(widget.thinness),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // CircleScaleAvatarWidget(
          //   shape: BoxShape.circle,
          //   color: Colors.white,
          //   margin: const EdgeInsets.all(10),
          //   fit: BoxFit.cover,
          //   begin: 0.9,
          //   end: 1,
          //   image: widget.img,
          // ),
          widget.child,
        ],
      ),
    );
  }
}
