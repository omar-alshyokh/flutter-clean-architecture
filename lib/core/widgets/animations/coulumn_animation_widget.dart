import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ColumnAnimationWidget extends StatelessWidget {
  final List<Widget> children;
  final double? verticalOffset;
  final double? horizontalOffset;
  final Duration? duration;
  final Duration? delay;
  final Duration? itemDuration;
  final Duration? itemDelay;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  const ColumnAnimationWidget({super.key,
    required this.children,
    this.mainAxisSize= MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.duration,
    this.delay,
    this.horizontalOffset,
    this.itemDelay,
    this.itemDuration,
    this.verticalOffset});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        mainAxisSize:mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: AnimationConfiguration.toStaggeredList(
          duration: duration,
          delay: delay,
          childAnimationBuilder: (widget) =>
              SlideAnimation(
                horizontalOffset: horizontalOffset,
                verticalOffset: verticalOffset,
                duration: itemDuration,
                delay: itemDelay,
                child: widget,
              ),
          children: children,
        ),
      ),
    );
  }
}
