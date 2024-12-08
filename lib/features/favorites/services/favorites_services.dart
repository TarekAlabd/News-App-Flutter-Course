import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_services.dart';
import 'package:news_app/core/utils/app_constants.dart';

class FavoritesServices {
  final localDatabaseServices = LocalDatabaseServices();

  Future<List<Article>> getFavorites() async {
    final favArticlesRaw = await localDatabaseServices.getStringList(AppConstants.favoritesKey);
    if (favArticlesRaw == null) return [];
    return favArticlesRaw.map((e) => Article.fromJson(e)).toList();
  }
}
