import 'package:flutter/material.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class TitleHeadlineWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const TitleHeadlineWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          child: Text(
            'View All',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }
}
