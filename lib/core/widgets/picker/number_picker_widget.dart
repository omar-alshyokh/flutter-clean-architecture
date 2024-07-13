import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter/core/constants/app_colors.dart';
import 'package:starter/core/constants/app_text_style.dart';
import 'package:starter/core/utils/app_utils.dart';

class NumberPickerWidgetWithLabel extends StatefulWidget {
  final String? text;
  final int maxNumber;
  final void Function(int) onPick;
  final double borderRadius;
  final Color? color;

  const NumberPickerWidgetWithLabel(
      {super.key,  this.text, required this.onPick, this.maxNumber = 100, this.borderRadius = 0.0,this.color});

  @override
  State<NumberPickerWidgetWithLabel> createState() =>
      _NumberPickerWidgetWithLabelState();
}

class _NumberPickerWidgetWithLabelState
    extends State<NumberPickerWidgetWithLabel> {
  late final List<int>items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = List<int>.generate(widget.maxNumber, (i) => i );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
              side: BorderSide(color: widget.color??AppColors.primaryColor, width: 2.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: widget.color??AppColors.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text??'',
                style: appTextStyle.normalTSBasic.copyWith(
                    color: widget.color??AppColors.primaryColor, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 120,
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (index) {
                    appPrint("item pick ${items[index]}");
                    widget.onPick(items[index]);
                  },
                  looping: true,
                  children: items
                      .map((e) =>
                      Center(
                        child: Text(
                          '$e',
                          style: appTextStyle.middleTSBasic
                              .copyWith(color: widget.color??AppColors.primaryColor),
                        ),
                      ))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
