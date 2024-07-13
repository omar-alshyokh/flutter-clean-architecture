import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ConfirmDialog extends StatefulWidget {
  final String title;
  final String desc;
  final String? confirmBtnTxt;
  final String? cancelBtnTxt;
  final VoidCallback confirmAction;

  const ConfirmDialog(
      {Key? key,
      required this.desc,
      required this.title,
      this.confirmBtnTxt,
      this.cancelBtnTxt,
      required this.confirmAction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ConfirmDialogState();
}

class ConfirmDialogState extends State<ConfirmDialog>
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
                  const SizedBox(height: 15,),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppDimens.space4),
                    // alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      widget.desc,
                      style: appTextStyle.normalTSBasic
                          .copyWith(color: AppColors.black,        fontSize: AppTextSize.middle,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          widget.cancelBtnTxt??'Cancel',
                          style: appTextStyle.normalTSBasic
                              .copyWith(color: AppColors.grey,  fontSize: AppTextSize.middle,),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        onPressed: widget.confirmAction,
                        child: Text(
                          widget.confirmBtnTxt ??'Confirm',
                          style: appTextStyle.middleTSBasic
                              .copyWith(color: AppColors.black,  fontSize: AppTextSize.middle,),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
