import 'package:flutter/cupertino.dart';
import 'package:starter/core/widgets/animations/coulumn_animation_widget.dart';

class CenteredItemsWidget extends StatelessWidget {
  final List<Widget> items;
  final Widget? button;
  final bool isButtonVisible;
  final MainAxisAlignment mainAxisAlignment;

  const CenteredItemsWidget({
    super.key,
    required this.items,
    this.button,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.isButtonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final widgetHeight = constraints.maxHeight;
        const buttonHeight = 80.0;
        final childHeight = widgetHeight - buttonHeight;
        return SizedBox(
          height: widgetHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: childHeight,
                  child: Column(
                    mainAxisAlignment: mainAxisAlignment,
                    children: items,
                  ),
                ),
              ),
              Visibility(
                visible: isButtonVisible && button != null,
                child: Container(
                  alignment: Alignment.center,
                  height: buttonHeight,
                  child: Container(
                      height: buttonHeight - 10,
                      alignment: AlignmentDirectional.topCenter,
                      child: button),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CenteredAnimationItemsWidget extends StatelessWidget {
  final List<Widget> items;
  final Widget? button;
  final bool isButtonVisible;
  final MainAxisAlignment mainAxisAlignment;

  const CenteredAnimationItemsWidget({
    super.key,
    required this.items,
    this.button,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.isButtonVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final widgetHeight = constraints.maxHeight;
        const buttonHeight = 80.0;
        final childHeight = widgetHeight - buttonHeight;
        return SizedBox(
          height: widgetHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  height: childHeight,
                  child: ColumnAnimationWidget(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalOffset: 100,
                    // delay: const Duration(milliseconds: 444),
                    // duration: const Duration(milliseconds: 444),
                    // itemDelay: const Duration(milliseconds: 333),
                    // itemDuration: const Duration(milliseconds: 444),
                    mainAxisAlignment: mainAxisAlignment,
                    children: items,
                  ),
                ),
              ),
              Visibility(
                visible: isButtonVisible && button != null,
                child: Container(
                  alignment: Alignment.center,
                  height: buttonHeight,
                  child: Container(
                      height: buttonHeight - 10,
                      alignment: AlignmentDirectional.topCenter,
                      child: button),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
