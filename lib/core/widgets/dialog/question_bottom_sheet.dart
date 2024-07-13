import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class QuestionBottomSheetWidget extends StatefulWidget {
  const QuestionBottomSheetWidget({
    Key? key,
    required this.screenwidth,
    required this.margins,
    required this.firstActiontitle,
    required this.secondActiontitle,
     this.secondActionTitleColor,
     this.firstActionTitleColor,
    required this.title,
    required this.firsActionFn,
    required this.secondActionFn,
  }) : super(key: key);

  final double screenwidth;
  final double margins;
  final String title;
  final String firstActiontitle;
  final String secondActiontitle;
  final Color? firstActionTitleColor;
  final Color? secondActionTitleColor;
  final Function firsActionFn;
  final Function secondActionFn;

  @override
  State<QuestionBottomSheetWidget> createState() => _QuestionBottomSheetWidgetState();
}

class _QuestionBottomSheetWidgetState extends State<QuestionBottomSheetWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.white800,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppDimens.space28,),
          Container(
            alignment: AlignmentDirectional.centerStart,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              widget.title,
              textAlign: TextAlign.start,
              style: appTextStyle.middleTSBasic.copyWith(fontSize: 15,fontWeight: FontWeight.w600, color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(height: AppDimens.space28,),
          Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: widget.screenwidth,
              // color: Colors.white,
              child: Column(
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () => {
                      setState(() {
                        selectedIndex = 0;
                        widget.firsActionFn();
                      })
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      height: AppDimens.fieldHeight * widget.screenwidth,
                      width: widget.screenwidth,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: selectedIndex == 0 ? AppColors.primaryColor : AppColors.grey50,
                        shape: BoxShape.rectangle,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 2,
                          color: Colors.transparent,
                        ),
                      ),
                      child: Text(
                        widget.firstActiontitle,
                        textAlign: TextAlign.center,
                        style: appTextStyle.middleTSBasic.copyWith(
                          color: selectedIndex == 0 ? AppColors.white : widget.firstActionTitleColor??AppColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => {
                        setState(() {
                          selectedIndex = 1;
                          widget.secondActionFn();
                        })
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: AppDimens.fieldHeight * widget.screenwidth,
                          width: widget.screenwidth,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: selectedIndex == 1 ? AppColors.primaryColor : AppColors.grey50,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                width: 2,
                                color: Colors.transparent,
                              )),
                          child: Text(
                            widget.secondActiontitle,
                            textAlign: TextAlign.center,
                            style: appTextStyle.middleTSBasic.copyWith(
                              color: selectedIndex == 1 ? AppColors.white : widget.secondActionTitleColor ?? AppColors.primaryColor,
                              fontSize: 14,
                            ),
                          )))
                ],
              )),
          const SizedBox(height: AppDimens.space30,),
        ],
      ),
    );
  }
}