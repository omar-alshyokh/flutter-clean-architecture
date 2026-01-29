import 'package:flutter/widgets.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context, {
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  })
  builder;

  const ResponsiveBuilder({
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    return builder(
      context,
      isMobile: isMobile,
      isTablet: isTablet,
      isDesktop: isDesktop,
    );
  }
}
