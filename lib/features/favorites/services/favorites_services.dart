import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/services/local_database_services.dart';
import 'package:news_app/core/utils/app_constants.dart';

class FavoritesServices {
  final localDatabaseServices = LocalDatabaseServices();
  final localDatabaseHive = LocalDatabaseHive();

  Future<List<Article>> getFavorites() async {
    final favArticlesRaw = await localDatabaseServices.getStringList(AppConstants.favoritesKey);
    if (favArticlesRaw == null) return [];
    return favArticlesRaw.map((e) => Article.fromJson(e)).toList();
  }

  Future<List<Article>> getFavoritesHive() async {
    final favorites = await localDatabaseHive.getData<List<dynamic>?>(
      AppConstants.favoritesKey,
    );

    if (favorites == null) {
      return [];
    }
    return favorites.map((e) => e as Article).toList();
  }
}
