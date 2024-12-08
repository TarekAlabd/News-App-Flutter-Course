import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/core/cubit/favorite_actions/favorite_actions_cubit.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class ArticleWidgetItem extends StatelessWidget {
  final Article article;
  final bool isSmaller;
  final bool isFavorite;
  const ArticleWidgetItem({
    super.key,
    required this.article,
    this.isSmaller = false,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(article.isFavorite.toString());
    final favoriteActionsCubit = BlocProvider.of<FavoriteActionsCubit>(context);
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
          Stack(
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
              PositionedDirectional(
                top: 8,
                end: 8,
                child: BlocBuilder<FavoriteActionsCubit, FavoriteActionsState>(
                  bloc: favoriteActionsCubit,
                  buildWhen: (previous, current) =>
                      (current is DoingFavorite &&
                          current.title == article.title) ||
                      (current is FavoriteAdded &&
                          current.title == article.title) ||
                      (current is FavoriteRemoved &&
                          current.title == article.title) ||
                      (current is DoingFavoriteError &&
                          current.title == article.title),
                  builder: (context, state) {
                    if (state is DoingFavorite) {
                      return const CircularProgressIndicator.adaptive();
                    } else if (state is FavoriteAdded ||
                        (state is FavoriteRemoved && !isFavorite)) {
                      return InkWell(
                        onTap: () async =>
                            await favoriteActionsCubit.setFavorite(article),
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              state is FavoriteAdded
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_outlined,
                            ),
                          ),
                        ),
                      );
                    }
                    return InkWell(
                      onTap: () async =>
                          await favoriteActionsCubit.setFavorite(article),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            article.isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_outlined,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
