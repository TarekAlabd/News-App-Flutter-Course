import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/services/local_database_services.dart';
import 'package:news_app/core/utils/app_constants.dart';

part 'favorite_actions_state.dart';

class FavoriteActionsCubit extends Cubit<FavoriteActionsState> {
  FavoriteActionsCubit._internal() : super(FavoriteActionsInitial());

  static final FavoriteActionsCubit _instance =
      FavoriteActionsCubit._internal();

  factory FavoriteActionsCubit() => _instance;

  // final localDatabaseServices = LocalDatabaseServices();
  final localDatabaseHive = LocalDatabaseHive();

  Future<void> setFavorite(Article article) async {
    emit(DoingFavorite(article.title ?? ''));
    try {
      final favArticles = await _getFavorites();
      final isFound =
          favArticles.any((element) => element.title == article.title);
      if (isFound) {
        final index =
            favArticles.indexWhere((element) => element.title == article.title);
        favArticles.remove(favArticles[index]);
        // await localDatabaseServices.setStringList(
        //   AppConstants.favoritesKey,
        //   favArticles.map((e) => e.toJson()).toList(),
        // );
        await localDatabaseHive.saveData<List<Article>>(
          AppConstants.favoritesKey,
          favArticles,
        );
        emit(FavoriteRemoved(article.title ?? ''));
      } else {
        favArticles.add(article);
        // await localDatabaseServices.setStringList(
        //   AppConstants.favoritesKey,
        //   favArticles.map((e) => e.toJson()).toList(),
        // );
        await localDatabaseHive.saveData<List<Article>>(
          AppConstants.favoritesKey,
          favArticles,
        );
        emit(FavoriteAdded(article.title ?? ''));
      }
      // debugPrint('favArticles: ${favArticles.length}');
    } catch (e) {
      emit(DoingFavoriteError(e.toString(), article.title ?? ''));
    }
  }

  Future<List<Article>> _getFavorites() async {
    // final favorites = await localDatabaseServices.getStringList(
    //   AppConstants.favoritesKey,
    // );
    final favorites = await localDatabaseHive.getData<List<dynamic>?>(
      AppConstants.favoritesKey,
    );

    if (favorites == null) {
      return [];
    }



    // final List<Article> favArticles = [];
    // if (favorites != null) {
    //   for (var favArticleString in favorites) {
    //     final favArticle = Article.fromJson(favArticleString);
    //     favArticles.add(favArticle);
    //   }
    // }
    return favorites.map((e) => e as Article).toList();
  }
}
