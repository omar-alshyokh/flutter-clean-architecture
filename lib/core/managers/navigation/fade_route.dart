import 'package:flutter/cupertino.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;
  final Duration transitionDuration;

  FadeRoute({required this.page,super.settings, this.transitionDuration= const Duration(milliseconds: 333)})
      : super(
          pageBuilder: (ctx, animation, secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) => FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.5, 1.0),
                ),
              ),
              child: child),
          transitionDuration: transitionDuration,
        );
}


class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final Duration transitionDuration;

  SlideRoute({required this.page,super.settings, this.transitionDuration = const Duration(milliseconds: 666)})
      : super(
          pageBuilder: (ctx, animation, secondaryAnimation) {
            return page;
          },
          transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );

          },
          transitionDuration: transitionDuration,
        );
}
