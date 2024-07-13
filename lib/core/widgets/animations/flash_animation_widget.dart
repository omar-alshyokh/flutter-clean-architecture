import 'package:flutter/material.dart';

class FlashingCardWidget extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color animatedColor;
  final ShapeBorder? shape;
  const FlashingCardWidget({super.key, required this.child,required this.color,required this.animatedColor,this.shape});
  @override
  _FlashingCardState createState() => _FlashingCardState();
}

class _FlashingCardState extends State<FlashingCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late  Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the ColorTween here
    _colorAnimation = ColorTween(
      begin: widget.animatedColor, // Original color
      end: widget.color, // Flash color
    ).animate(_controller)
      ..addListener(() {
        setState(() {

        });
      });

    _controller.forward(); // Start the animation
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Card(
          color: _colorAnimation.value,
          shape: widget.shape,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
