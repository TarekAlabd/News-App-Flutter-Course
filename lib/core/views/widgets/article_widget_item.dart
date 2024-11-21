import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class ArticleWidgetItem extends StatelessWidget {
  final Article article;
  final bool isSmaller;
  const ArticleWidgetItem({
    super.key,
    required this.article,
    this.isSmaller = false,
  });

  @override
  Widget build(BuildContext context) {
    final parsedDate =
        DateTime.parse(article.publishedAt ?? DateTime.now().toString());
    final formattedDate = DateFormat.yMMMd().format(parsedDate);
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        AppRoutes.articleDetails,
        arguments: article,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ??
                  'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
              width: isSmaller ? 140 : 170,
              height: isSmaller ? 150 : 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.grey,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.title ?? '',
                  maxLines: isSmaller ? 2 : 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  article.source?.name ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
