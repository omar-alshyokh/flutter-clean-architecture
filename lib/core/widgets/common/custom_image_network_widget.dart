import 'package:flutter/material.dart';
import 'package:starter/core/constants/app_colors.dart';

class CustomImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit? fit;
  final Color? placeholderBGColor;

  const CustomImageNetworkWidget(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.fit,
      this.placeholderBGColor,
      this.radius = 0.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        color: placeholderBGColor,
        child: Image.network(
          imageUrl,
          height: height,
          width: width,
          fit: fit,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return SizedBox(
              width: width,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          },
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return SizedBox(
              width: width,
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  color: AppColors.darkYellow,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
