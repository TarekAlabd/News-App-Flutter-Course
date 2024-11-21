import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/views/widgets/article_widget_item.dart';

class RecommendationListWidget extends StatelessWidget {
  final List<Article> articles;
  const RecommendationListWidget({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final article = articles[index];
        return ArticleWidgetItem(article: article);
      },
    );
  }
}
