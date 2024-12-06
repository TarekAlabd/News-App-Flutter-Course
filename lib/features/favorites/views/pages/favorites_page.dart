import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/views/widgets/article_widget_item.dart';
import 'package:news_app/features/favorites/cubit/favorites_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        bloc: favoritesCubit,
        buildWhen: (previous, current) =>
            current is FavoritesLoading ||
            current is FavoritesLoaded ||
            current is FavoritesError,
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is FavoritesLoaded) {
            final articles = state.articles;

            if (articles.isEmpty) {
              return const Center(
                child: Text('No favorites yet!'),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: articles.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                itemBuilder: (_, index) {
                  final article = articles[index];

                  return ArticleWidgetItem(
                    article: article,
                    isSmaller: true,
                    isFavorite: true,
                  );
                },
              ),
            );
          } else if (state is FavoritesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
