import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/presentation/layout/app_padding.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final bool scrollable;
  final EdgeInsets? padding;

  const ScreenWrapper({
    super.key,
    required this.child,
    this.scrollable = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ?? AppPadding.screen,
      child: child,
    );

    return SafeArea(
      child: scrollable
          ? SingleChildScrollView(child: content)
          : content,
    );
  }
}
