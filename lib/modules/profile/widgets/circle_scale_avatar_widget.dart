import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleScaleAvatarWidget extends StatefulWidget {
  const CircleScaleAvatarWidget({
    super.key,
    required this.image,
    required this.begin,
    required this.end,
    required this.fit,
    required this.margin,
    required this.color,
    required this.shape,
  });

  final String image;
  final double begin;
  final double end;
  final BoxFit fit;
  final EdgeInsetsGeometry margin;
  final Color color;
  final BoxShape shape;

  @override
  State<CircleScaleAvatarWidget> createState() =>
      _CircleScaleAvatarWidgetState();
}

class _CircleScaleAvatarWidgetState extends State<CircleScaleAvatarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Tween<double> _tween;
  @override
  void initState() {
    _tween = Tween(begin: widget.begin, end: widget.end);
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animationController.repeat(
      reverse: true,
      // period: const Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _tween.animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.decelerate,
        ),
      ),
      child: Container(
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.color,
          shape: widget.shape,
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: widget.image,
            fit: widget.fit,
          ),
        ),
      ),
    );
  }
}
