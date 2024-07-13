import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final Widget child;


  const CustomDialog(
      {Key? key,
      required this.child,
      required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.only(left: 20,right: 20),
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 10,),
                  Text(
                    widget.title,
                    style: appTextStyle.middleTSBasic.copyWith(
                      fontSize: AppTextSize.subBig,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0,),
                  const Divider(color: AppColors.primaryColor,),
                  const SizedBox(height: 8.0,),

                  widget.child
                ],
              )),
        ),
      ),
    );
  }
}
