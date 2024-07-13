import 'package:flutter/material.dart';
import 'package:starter/core/constants/app_colors.dart';
import 'package:starter/core/constants/app_text_style.dart';

class ButtonCounterWidgetWithLabel extends StatefulWidget {
  final void Function(int) onTap;
  final double borderRadius;
  final int initCount;
  final String? text;
  final Color? color;
  final String heroTag;

  const ButtonCounterWidgetWithLabel(
      {super.key,
      required this.onTap,
      required this.initCount,
      required this.heroTag,
      this.borderRadius = 0.0,
      this.text,
      this.color});

  @override
  State<ButtonCounterWidgetWithLabel> createState() =>
      _ButtonCounterWidgetWithLabelState();
}

class _ButtonCounterWidgetWithLabelState
    extends State<ButtonCounterWidgetWithLabel> {
  int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _count = widget.initCount;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (mounted) {
          setState(() {
            _count = _count + 1;
          });
        }
        widget.onTap(_count);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          side: BorderSide(
              color: widget.color ?? AppColors.primaryColor, width: 2.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(color: widget.color??AppColors.primaryColor, width: 2.0),
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.text != null && widget.text?.isNotEmpty == true)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${widget.text}',
                      style: appTextStyle.normalTSBasic.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '$_count',
                style: appTextStyle.normalTSBasic.copyWith(
                    color: widget.color ?? AppColors.primaryColor,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                backgroundColor: widget.color ?? AppColors.primaryColor,
                heroTag: widget.heroTag,
                child: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      _count = _count + 1;
                    });
                  }
                  widget.onTap(_count);
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
