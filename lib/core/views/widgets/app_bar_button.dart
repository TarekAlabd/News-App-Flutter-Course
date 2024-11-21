import 'package:flutter/material.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppBarButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final bool hasPaddingBetween;

  const AppBarButton({
    super.key,
    required this.iconData,
    required this.onTap,
    this.hasPaddingBetween = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.grey2,
        ),
        child: Padding(
          padding: EdgeInsets.all(hasPaddingBetween ? 8.0 : 0.0),
          child: Icon(
            iconData,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
