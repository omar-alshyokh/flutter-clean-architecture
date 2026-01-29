import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/core/constants/app_spacing.dart';

abstract class AppPadding {
  static const EdgeInsets screen =
  EdgeInsets.all(AppSpacing.md);

  static const EdgeInsets horizontal =
  EdgeInsets.symmetric(horizontal: AppSpacing.md);

  static const EdgeInsets vertical =
  EdgeInsets.symmetric(vertical: AppSpacing.md);

  static const EdgeInsets listItem =
  EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
    vertical: AppSpacing.sm,
  );
}
