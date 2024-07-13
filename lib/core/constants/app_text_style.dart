import 'package:flutter/material.dart';
import 'constants.dart';

///    use this instance
AppTextStyle appTextStyle = AppTextStyle();

class AppTextStyle {

  /// ===============================================
  ///          default text styles here
  /// ===============================================
  final hugeTSBasic = const TextStyle(
    fontSize: AppTextSize.huge,
  );

  final largestTSBasic = const TextStyle(
    fontSize: AppTextSize.largest,
  );

  final largerTSBasic = const TextStyle(
    fontSize: AppTextSize.larger,
  );
  final subLargeTSBasic = const TextStyle(
    fontSize: AppTextSize.subLarge,
  );

  final bigTSBasic = const TextStyle(
    fontSize: AppTextSize.big,
  );

  //========================subBig======================================

  final subBigTSBasic = const TextStyle(
    fontSize: AppTextSize.subBig,
  );

  //========================normal======================================

  final normalTSBasic = const TextStyle(
    fontSize: AppTextSize.normal,
  );

  //=========================middle======================================

  final middleTSBasic = const TextStyle(
    fontSize: AppTextSize.middle,
  );

  //=========================small======================================

  final smallTSBasic = const TextStyle(
    fontSize: AppTextSize.small,
  );

  //========================min======================================
  final minTSBasic = const TextStyle(
    fontSize: AppTextSize.min,
  );

  //========================sub-min======================================

  final subMinTSBasic = const TextStyle(
    fontSize: AppTextSize.subMin,
  );

  //========================sub-2-min======================================

  final sub2MinTSBasic = const TextStyle(
    fontSize: AppTextSize.sub2Min,
  );

  //========================sub-3-min======================================

  final sub3MinTSBasic = const TextStyle(
    fontSize: AppTextSize.sub3Min,
  );
}
